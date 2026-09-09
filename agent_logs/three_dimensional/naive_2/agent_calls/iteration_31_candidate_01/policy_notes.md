# Carrier-separated predictive-course candidate

## Visual and rollout diagnosis before editing

All four sampled evaluations satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected every combined keyframe sheet from release through
capture, including both its top-down mid-plane vorticity row and oblique
body/Lambda2 row. Each controller self-propels on the same direct down-left
route. The alternating wake stays compact and attached to the posterior body;
there is no visible advection, wake breakup, collision, or domain-exit event to
justify changing the carrier or far-field route.

The informative failure is terminal margin rather than termination class. The
prefilled unified response-plus-miss controller `solver_e0a2513d969f` captures
at `15.5008T` with score `-0.02109`, a `0.179L` raw projected course miss, and
nearly targetward velocity `(-1.286,-0.014)L/T`. Instantaneous target-line
steering (`solver_f792c48d0852`) improves scalar score to `-0.01965` but widens
the miss to `0.674L`; posterior phase-lag steering
(`solver_dc562b1ee0c2`) ends at `0.727L`. The assigned parent's persistence
consensus (`solver_8600d052eff8`) still captures and scores `-0.02023`, but it
widens the projected miss again to `0.747L` and its terminal radial velocity is
already slightly receding (`-0.113L/T`). All four remain in the same compact
wake and load class: peak normalized planar force/moment are about
`0.0355--0.0371/0.0174--0.0183`, neither joint dwells above `40 deg`, and
near-rate occupancy remains roughly `18--19%`. Thus persistence gating did not
convert target-line rate into terminal margin, and another rate gain, threshold,
or actuator transfer is not supported.

The trajectory histories expose a different beat-scale contamination. For
`t>4T`, a body-frame carrier model
`v_carrier_y = -0.15*phi_dot1 + 0.105*phi_dot2` explains about `92%` of sampled
lateral-speed variance when a constant and slow target-lateral term are allowed
in the diagnostic fit. The fitted head coefficient spans only
`-0.144-- -0.155` and the tail coefficient `0.087--0.121` across the four
controllers. Subtracting this carrier estimate reduces near-field projected-
miss RMS in every sample and separates the centered capture's compensated final
miss (`0.462L`) from the three wide crossings (`0.744--0.747L`). This is
diagnostic evidence for changing the observation used by the predictive
handoff, not evidence that the unevaluated candidate will improve CFD.

## Single candidate hypothesis

Preserve the prefilled controller's owned state-feedback carrier, posterior
lag and pulse, raw far-field pursuit/course blend, bounded mean bend,
response-plus-miss release, half-cycle steering actuator, and smooth command
envelope. Add one carrier-separated observation mechanism only: within the
existing distance handoff, subtract a bounded two-joint-rate estimate of
carrier-induced lateral velocity before computing time-to-closest,
closing alignment, and predicted miss. Raw measured velocity continues to own
far-field navigation, so the evidenced direct route and wake are unchanged
outside the terminal handoff. The model uses normalized body-frame velocity
and joint state, has no clock, coordinate, case identity, or mutable history,
and remains odd under left/right reflection.

The hypothesis is that the unified handoff releases rhythmic correction on an
instantaneous carrier-biased course sample. Carrier-separated predictive
geometry should retain redirect authority until the underlying course is
centered, then return to the same cruise carrier without introducing a new
steering actuator. Support requires capture with projected miss below the
wide-crossing `0.674L` boundary and preferably below the semantic replicate's
`0.590L`, arrival and score near the evidenced `15.50--15.78T` and
`-0.02109---0.01965` range, the same direct route and compact wake, no
`>40 deg` dwell, near-rate occupancy near the inherited `18--19%` class, and
peak normalized force/moment no worse than about `0.037/0.019`. Falsify on a
miss or worse termination, projected miss at or above `0.674L`, loss of
pre-approach translation, wake decoherence, a higher joint/load class,
nonfinite or unbounded commands, or reflection error. Formal CFD is deferred
to EvE and is not same-worker evidence.

bookshelf_consulted: true
source_domain: wake-adaptive swimming and sensor-modulated robotic-fish rhythmic direction control
source_mechanism: separate slow target-relative motion from fast carrier-induced lateral motion before changing a bounded rhythmic steering handoff
transferable_invariant: a propulsive oscillator's observable phase can explain beat-scale lateral response that should be removed from the slower course estimate used to decide whether a redirect is complete
nontransferable_details: published gains, source history windows, dimensional frequencies, species-specific kinematics, robot geometry, exact vortex phase, task coordinates, routes, and waypoints
policy_translation: estimate carrier lateral velocity from normalized two-joint rates in the body frame, smoothly subtract it only inside the existing terminal distance gate, and use the separated velocity for predicted-miss geometry while preserving raw far-field steering and the two-joint carrier
falsification: reject if capture margin, termination, arrival, direct routing, wake coherence, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The lightweight public-contract check passes. A deterministic `32,805`-state
grid spanning target geometry, body-frame velocity, heading response, and both
joint angles and rates produced finite commands strictly inside the smooth
`30 rad/T^2` envelope with exact left/right reflection error `0.0`. The
carrier-separation mechanism changed `21,732` grid states relative to the
prefilled unified controller. Counterfactual evaluation on the four completed
trajectory histories changes near-field acceleration by about
`0.62--0.84 rad/T^2` on average and at most `7.25 rad/T^2`; far-field mean
change is only about `0.02 rad/T^2`, consistent with the distance-gated design.
These checks establish activity, boundedness, and symmetry only. They do not
predict the coupled CFD trajectory, whose formal evaluation remains deferred
to EvE.
