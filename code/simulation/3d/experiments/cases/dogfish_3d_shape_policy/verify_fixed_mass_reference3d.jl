# Dry-mass contract for the modeler-default body with the caudal fin only.
# This test is geometry-only: it creates no WaterLily Simulation and runs no CFD.

case_dir = @__DIR__
include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
using Printf
using Test

const REFERENCE_STATION = 1f0 / 3f0
const RESOLUTIONS = (16, 32, 64)

function mass_record(L::Int)
    Lf = Float32(L)
    body = dogfish_body_sdf(Lf)
    fin = modeler_caudal_fin(body)
    reference_x = REFERENCE_STATION * Lf
    props = combined_body_properties_superellipse(
        body;
        density=1f0,
        fin,
        fin_material_density=0f0,
        reference_x,
    )
    body_added = superellipse_added_mass(body; density=1f0, reference_x)
    fin_added = caudal_fin_added_mass(fin; density=1f0, centroid_x=reference_x)
    old_uniform = combined_body_properties_superellipse(
        body;
        density=1f0,
        fin,
        fin_material_density=1f0,
    )
    return (
        L,
        reference_s=props.centroid_x / Lf,
        physical_centroid_s=props.physical_mass_centroid_x / Lf,
        uniform_body_centroid_s=props.body_volume_centroid_x / Lf,
        fin_mass=props.fin_mass,
        dry_mass_L3=props.mass / Lf^3,
        dry_inertia_L5=props.inertia_z / Lf^5,
        fin_geometry_volume_L3=props.fin_volume / Lf^3,
        body_added_lateral_L3=body_added.lateral / Lf^3,
        body_added_yaw_L5=body_added.inertia / Lf^5,
        fin_added_lateral_L3=fin_added.lateral / Lf^3,
        fin_added_yaw_L5=fin_added.inertia / Lf^5,
        old_uniform_tail_mass_fraction=old_uniform.fin_mass / old_uniform.mass,
        old_uniform_centroid_s=old_uniform.centroid_x / Lf,
    )
end

records = mass_record.(RESOLUTIONS)

@testset "fixed modeler dogfish mass reference" begin
    for r in records
        @test r.reference_s ≈ REFERENCE_STATION atol=2f-6
        @test r.physical_centroid_s ≈ REFERENCE_STATION atol=2f-6
        @test r.fin_mass == 0f0
    end

    # Body-only dry mass and yaw inertia, as well as analytical added mass,
    # scale geometrically and therefore remain resolution invariant.
    invariant_fields = (
        :dry_mass_L3,
        :dry_inertia_L5,
        :uniform_body_centroid_s,
        :body_added_lateral_L3,
        :body_added_yaw_L5,
        :fin_added_lateral_L3,
        :fin_added_yaw_L5,
    )
    for field in invariant_fields
        baseline = getproperty(records[1], field)
        for r in records[2:end]
            @test getproperty(r, field) ≈ baseline rtol=3f-5 atol=2f-7
        end
    end

    # The watertight one-cell tail thickness is deliberately resolution
    # dependent. It may change displaced geometry, but cannot change dry mass
    # or the prescribed material center of mass.
    @test records[1].fin_geometry_volume_L3 > records[2].fin_geometry_volume_L3
    @test records[2].fin_geometry_volume_L3 > records[3].fin_geometry_volume_L3
    @test records[1].old_uniform_tail_mass_fraction > records[2].old_uniform_tail_mass_fraction
    @test records[2].old_uniform_tail_mass_fraction > records[3].old_uniform_tail_mass_fraction
end

println("resolution  COM/L    dry-mass/L^3  Iz/L^5       old-tail-mass  old-COM/L")
for r in records
    @printf(
        "L%-3d        %.6f  %.8f    %.8f  %8.3f%%      %.6f\n",
        r.L,
        r.reference_s,
        r.dry_mass_L3,
        r.dry_inertia_L5,
        100 * r.old_uniform_tail_mass_fraction,
        r.old_uniform_centroid_s,
    )
end
println("simulation_created=false")
