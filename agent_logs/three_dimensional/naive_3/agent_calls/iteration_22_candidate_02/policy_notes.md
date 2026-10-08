# Wake-policy candidate notes

## Evidence read before the edit

All four sampled rollouts report direct uniform initialization at
`U_infinity=(0,0,0)`, 235 moving-window shifts, finite dynamics, and capture
near `18.27T`; there is no prewarm artifact or failed termination in this
sample. The combined sheets show the same target-directed topology. In the
top-down row the fish translates under its own alternating wake from release
through capture, rather than being advected or settling into a held bend. The
oblique row retains compact three-dimensional Lambda2 structures and rhythmic
body motion through the approach. The trace supports that diagnosis: peak fish
speed is `1.329U`, whereas peak sampled local-flow speed is only `0.03154U`.

The useful contrast is mechanical. The highest-scoring fixed-width brake
captures at `0.74823L`, but its posterior joint reaches exactly `-45 deg` and
whole-trace force/yaw-moment peaks rise to `0.17183/0.07699`. Each sampled
velocity-conditioned stopping-margin policy captures on the visually same
route, stops near `-42.998 deg`, and holds those peaks to `0.03716/0.01907`.
Thus the inherited global posterior viability projection is useful and should
not be replaced by another spatial guard.

The remaining defect is demand economy. In the assigned capture trace, raw
anterior/posterior acceleration exceeds `1800 deg/T^2` in `51.28/46.40%` of
samples, and the two joint speeds touch `260 deg/T` in `160/89` of 3323
samples. An otherwise identical sampled candidate that explicitly clamps both
returned accelerations has exactly the same score, trajectory, wake, joint
history, and loads. That negative control shows that exact output clipping only
duplicates the downstream actuator; it does not test whether the carrier needs
bang-bang demand.

## Policy hypothesis recorded before the solver edit

Preserve the zero-centered anterior oscillator, posterior lag, full-quadrant
body-frame velocity-course steering, terminal acceleration reserve, and global
posterior stopping-margin barrier. Insert one new mechanism before the safety
barrier: a symmetric, knee-preserving smooth acceleration envelope. It is
exactly linear for moderate carrier/residual demand, approaches the physical
acceleration limit continuously above the knee, and never weakens the
posterior barrier's final authority. This changes the applied waveform near
saturation instead of merely relabeling the same clipped action.

The rollout should retain capture and both rows' alternating wake while
reducing raw acceleration exceedance and hard acceleration-limit occupancy.
Reject the mechanism if it loses capture, materially worsens the broad route or
distance integral, destroys coherent shedding, increases the established
`0.0372/0.0191` load envelope, reintroduces posterior angle contact, or leaves
joint-speed contact unchanged despite altering the waveform.

An offline command-map replay on the inherited trace was used only to reject a
nearly identity parameterization, not as CFD evidence. With a normalized
linear knee of `0.30`, the map changes mean absolute applied demand by about
`5.57%/4.83%` for the anterior/posterior commands and maps finite carrier
requests below `1800 deg/T^2`; the subsequent safety projection can still use
the full envelope. The new rollout must establish whether that counterfactual
command change improves actual joint motion and effort.

bookshelf_consulted: true
source_domain: robotic-fish CPG and residual-command control
source_mechanism: preserve a low-dimensional rhythmic carrier while sensor feedback modulates bounded command authority instead of issuing unconstrained high-frequency torque
transferable_invariant: keep the evidenced traveling rhythm and target residual, but make their combined demand continuously compatible with the actuator envelope before a higher-priority safety correction
nontransferable_details: published CPG gains, clock phases, species-specific envelopes, dimensional frequencies, exact vortex phases, and task routes
policy_translation: pass the existing two-joint state-feedback carrier and body-frame course residual through a normalized smooth acceleration envelope, then retain the posterior joint-state stopping-margin projection
falsification: reject if capture or alternating wake is lost, score or loads materially worsen, posterior contact returns, or acceleration and joint-speed limit occupancy do not fall
