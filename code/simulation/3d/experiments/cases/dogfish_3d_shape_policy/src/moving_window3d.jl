# Integer-cell moving window for free swimming in a uniform inertial flow.
#
# The field values remain inertial/world velocity components.  When the fish
# drifts more than a few cells from its local anchor, all stored flow fields
# are translated by the same integer number of cells, newly exposed cells are
# initialized to the prescribed inertial far-field velocity, and the
# world-to-local origin is advanced.
# Integer shifts avoid interpolation diffusion and, unlike an accelerating
# velocity frame, do not alter the rigid-body force balance.

@inline function moving_window_local_state(world_state, origin)
    T = eltype(world_state.center)
    local_origin = SVector{2, T}(T(origin[1]), T(origin[2]))
    return Base2D.FreeSwimState{T}(
        world_state.center - local_origin,
        world_state.theta,
        world_state.velocity,
        world_state.omega,
        world_state.acceleration,
        world_state.angular_acceleration,
    )
end

function moving_window_shift_cells(local_center, anchor, threshold_cells)
    delta = local_center - anchor
    return SVector{2, Int}(
        abs(delta[1]) >= threshold_cells ? round(Int, delta[1]) : 0,
        abs(delta[2]) >= threshold_cells ? round(Int, delta[2]) : 0,
    )
end

@inline function _shifted_scalar_value(source, I, shift_x::Int, shift_y::Int)
    source_x = I[1] - shift_x
    source_y = I[2] - shift_y
    if 1 <= source_x <= size(source, 1) && 1 <= source_y <= size(source, 2)
        return @inbounds source[CartesianIndex(source_x, source_y, I[3])]
    end
    return zero(eltype(source))
end

@inline function _shifted_vector_value(
    source, I, shift_x::Int, shift_y::Int, entering_velocity,
)
    source_x = I[1] - shift_x
    source_y = I[2] - shift_y
    if 1 <= source_x <= size(source, 1) && 1 <= source_y <= size(source, 2)
        return @inbounds source[CartesianIndex(source_x, source_y, I[3], I[4])]
    end
    return @inbounds entering_velocity[I[4]]
end

function shift_scalar_field_xy!(scratch, field, shift_x::Int, shift_y::Int)
    WaterLily.@loop scratch[I] = _shifted_scalar_value(
        field, I, shift_x, shift_y,
    ) over I in CartesianIndices(field)
    copyto!(field, scratch)
    return field
end

function shift_vector_field_xy!(
    scratch, field, shift_x::Int, shift_y::Int, entering_velocity,
)
    WaterLily.@loop scratch[I] = _shifted_vector_value(
        field, I, shift_x, shift_y, entering_velocity,
    ) over I in CartesianIndices(field)
    copyto!(field, scratch)
    return field
end

function shift_uniform_flow_window!(
    sim,
    scalar_scratch,
    vector_scratch,
    origin_delta_cells,
    entering_velocity,
)
    # x_local_new = x_local_old - origin_delta, hence old samples move by
    # -origin_delta in the array index space.
    shift_x = -Int(origin_delta_cells[1])
    shift_y = -Int(origin_delta_cells[2])
    shift_x == 0 && shift_y == 0 && return (shift_x=0, shift_y=0)

    length(entering_velocity) == size(sim.flow.u, 4) || error(
        "entering_velocity must have one value per stored velocity component",
    )
    shift_vector_field_xy!(
        vector_scratch, sim.flow.u, shift_x, shift_y, entering_velocity,
    )
    sim.flow.u⁰ .= sim.flow.u
    shift_scalar_field_xy!(scalar_scratch, sim.flow.p, shift_x, shift_y)
    WaterLily.BC!(
        sim.flow.u,
        sim.flow.uBC,
        sim.flow.exitBC,
        sim.flow.perdir,
        WaterLily.time(sim.flow),
    )
    sim.flow.exitBC && WaterLily.exitBC!(sim.flow.u, sim.flow.u, zero(eltype(sim.flow.p)))
    sim.flow.u⁰ .= sim.flow.u
    return (shift_x=shift_x, shift_y=shift_y)
end

# Compatibility wrapper for the validated quiescent-water cases.
function shift_quiescent_flow_window!(
    sim,
    scalar_scratch,
    vector_scratch,
    origin_delta_cells,
)
    entering_velocity = ntuple(_ -> zero(eltype(sim.flow.u)), size(sim.flow.u, 4))
    return shift_uniform_flow_window!(
        sim,
        scalar_scratch,
        vector_scratch,
        origin_delta_cells,
        entering_velocity,
    )
end
