# Step 39 wake-policy candidate

## Evidence diagnosis before the edit

All four sampled evaluations are valid direct-uniform `U_infinity=0` still-water
runs with no cylinders or prewarm. Their combined sheets show self-propelled
closed loops and coherent alternating top-down/oblique wakes through the
`100T` horizon; there is no visual evidence that passive advection or loss of
propulsion is the current limitation. The informative failure is shared
terminal geometry: the fish sweeps tangentially past the target, retains a
broad return loop, and settles near a common negative C-bend. The sampled
joint-state release, rear-centerline selector, posterior phase response, and
two-joint activity-floor variants all miss (`2.215--2.439L`) and finish
`3.310--3.502L` away. At each representative closest approach the anterior
joint speed is nearly zero, while the visible wake and roughly `0.65--0.68U`
translation remain finite.

The histories also separate a fast hydrodynamic cue from the slow route cue.
For every sampled policy, among states inside `3L`, course-signed body-frame
lateral force has a positive association with improvement in absolute course
error `0.25T` later (`r=0.432--0.458`), but the association reverses at `0.5T`
(`r=-0.230---0.285`). This does not establish force as a causal steering
signal. It does support using it only as a beat-scale selector while the
persistent normalized target-ray/course error continues to own turn direction.

## Candidate hypothesis

Restore the evidence-backed, phase-balanced two-sided anterior energy law
without changing its mean bend, activity target, or carrier. Add one new role
to the posterior joint: under the existing target-behind terminal course hold,
softly reduce posterior tracking authority only during the measured lateral-
load half-cycle associated with subsequent inward course rotation. This is a
bounded load-selected compliance action, not posterior energy injection,
static counterbend, phase-lag retuning, or force-as-heading feedback. It leaves
the entire first approach and nominal lagged traveling wave unchanged outside
the narrow terminal gate.

Expected evidence is the preserved first return and active anterior rhythm,
followed by a smaller tangential course error or longer residence inside
`1.25L` without higher clamp/load residence. Reject the mechanism if the first
return changes, the body or tail parks again, the wake loses coherence, force
or action peaks rise materially, yaw increases without inward course rotation,
or near-target residence/final return does not beat the anterior-only result.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG control and adaptive wake interaction
source_mechanism: separate slow route feedback from fast load feedback, and modulate rhythmic actuator compliance instead of prescribing a vortex phase
transferable_invariant: persistent body-frame target/course geometry selects turn direction while a bounded fast hydrodynamic cue may select when an actuator yields to a helpful lateral impulse
nontransferable_details: published gains, species-specific kinematics, dimensional frequencies, exact vortex phases, cylinder-wake routes, and multi-joint CPG layouts
policy_translation: preserve the normalized course-hold and two-sided anterior carrier; use normalized course sign times body-frame lateral force to reduce posterior tracking authority only inside the existing terminal gate
falsification: reject on a changed first return, another parked bend, degraded wake/load margins, yaw without inward course rotation, or no improvement in near-target residence and final return
