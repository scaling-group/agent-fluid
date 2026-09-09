const LEGACY_WAKE_SCORE_MODE = "navigation_with_reach_bonus_v1"
const TARGET_REACHED_ENERGY_BONUS_SCORE_MODE =
    "navigation_with_reach_bonus_and_target_energy_bonus_v1"
const TARGET_REACHED_ENERGY_BONUS_SCORE_SCHEMA =
    "dogfish.wake_navigation_plus_target_energy_bonus.v1"

function actuator_effort_envelope(
    metric::AbstractString,
    phi_dot_limit::Real,
    phi_ddot_limit::Real,
    horizon::Real,
)
    phi_dot_bound = abs(Float64(phi_dot_limit))
    phi_ddot_bound = abs(Float64(phi_ddot_limit))
    horizon_bound = Float64(horizon)
    isfinite(phi_dot_bound) || error("phi_dot_limit must be finite")
    isfinite(phi_ddot_bound) || error("phi_ddot_limit must be finite")
    isfinite(horizon_bound) || error("horizon must be finite")
    phi_dot_bound > 0 || error("phi_dot_limit must be positive")
    phi_ddot_bound > 0 || error("phi_ddot_limit must be positive")
    horizon_bound > 0 || error("horizon must be positive")

    metric == "power_proxy" &&
        return 2.0 * phi_dot_bound * phi_ddot_bound * horizon_bound
    metric == "command_energy" &&
        return 2.0 * phi_ddot_bound^2 * horizon_bound
    error("unsupported success energy metric: $metric")
end

function target_reached_energy_bonus_score(
    target_reached::Bool,
    energy_proxy::Real,
    energy_envelope::Real,
    base_score::Real;
    energy_bonus_weight::Real=1.0,
)
    energy = Float64(energy_proxy)
    envelope = Float64(energy_envelope)
    base = Float64(base_score)
    weight = Float64(energy_bonus_weight)
    isfinite(energy) || error("energy_proxy must be finite")
    isfinite(envelope) || error("energy_envelope must be finite")
    isfinite(base) || error("base_score must be finite")
    isfinite(weight) || error("energy_bonus_weight must be finite")
    energy >= 0 || error("energy_proxy must be non-negative")
    envelope > 0 || error("energy_envelope must be positive")
    weight >= 0 || error("energy_bonus_weight must be non-negative")

    energy_fraction = clamp(energy / envelope, 0.0, 1.0)
    energy_efficiency = 1.0 - energy_fraction
    energy_bonus = target_reached ? weight * energy_efficiency : 0.0
    return (
        score=base + energy_bonus,
        base_score=base,
        energy_fraction=energy_fraction,
        energy_efficiency=energy_efficiency,
        energy_bonus=energy_bonus,
        energy_bonus_weight=weight,
    )
end
