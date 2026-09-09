const PRIVILEGED_WAKE_POLICY_OBSERVATION_FIELDS = (
    :inflow_velocity_body,
    :inflow_velocity_body_U,
    :cylinder_wake_probe_offsets_L,
    :cylinder_wake_probe_velocity,
    :cylinder_wake_probe_velocity_body,
    :cylinder_wake_probe_velocity_body_U,
    :cylinder_wake_streamwise_velocity,
    :cylinder_wake_crossflow_velocity,
    :cylinder_wake_vorticity,
    :station_flow_velocity_body,
    :station_flow_velocity_body_U,
    :station_streamwise_velocity,
    :station_crossflow_velocity,
    :station_vorticity,
)

const PRIVILEGED_WAKE_POLICY_OBSERVATION_MASK =
    NamedTuple{PRIVILEGED_WAKE_POLICY_OBSERVATION_FIELDS}(
        ntuple(_ -> nothing, length(PRIVILEGED_WAKE_POLICY_OBSERVATION_FIELDS)),
    )

"""
    wake_policy_observation(observation)

Return the deployable observation exposed to `target_policy`.

The full wake observation may retain simulator-only fields for offline
diagnostics, but the policy boundary excludes prescribed inflow and remote CFD
probes that a physical robot fish could not measure locally.
"""
function wake_policy_observation(observation::NamedTuple)
    return Base.structdiff(
        observation,
        PRIVILEGED_WAKE_POLICY_OBSERVATION_MASK,
    )
end
