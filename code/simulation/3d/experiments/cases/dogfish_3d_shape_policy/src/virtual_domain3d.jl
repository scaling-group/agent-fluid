"""Check the inertial 2D task boundary while CFD storage follows the fish.

The material reference (fish center) uses the same interior margin as the
August-5 2D 24L x 16L case. The material head must remain inside the full
virtual field. Coordinates and `length_scale` may be any real numeric type.
"""
@inline function virtual_domain_exit(
    world_center,
    world_head,
    length_scale,
    domain_x_L,
    domain_y_L,
    center_margin_L,
)
    center_x_L = Float64(world_center[1] / length_scale)
    center_y_L = Float64(world_center[2] / length_scale)
    head_x_L = Float64(world_head[1] / length_scale)
    head_y_L = Float64(world_head[2] / length_scale)
    domain_x = Float64(domain_x_L)
    domain_y = Float64(domain_y_L)
    margin = Float64(center_margin_L)

    center_outside = !(
        margin <= center_x_L <= domain_x - margin &&
        margin <= center_y_L <= domain_y - margin
    )
    head_outside = !(
        0.0 <= head_x_L <= domain_x &&
        0.0 <= head_y_L <= domain_y
    )
    return (
        outside=center_outside || head_outside,
        center_outside,
        head_outside,
        center_L=(center_x_L, center_y_L),
        head_L=(head_x_L, head_y_L),
    )
end
