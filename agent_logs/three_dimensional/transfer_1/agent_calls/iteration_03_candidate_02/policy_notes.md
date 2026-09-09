# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled evaluations are direct-uniform still-water releases with
  `U_infinity=(0,0,0)`, not prewarmed or advected cases. All are finite,
  self-propelled `left_domain` failures. Their top-down sheets show alternating
  vorticity streets and their oblique rows show compact three-dimensional
  Lambda2 structures, so neither missing propulsion nor wake blow-up is the
  common failure.
- The prefilled achieved-course servo is the most useful trajectory even
  though its scalar score is not the highest. It closes from `12.328L` to
  `1.044L` at `18.85T`; the next-best closest approach is `3.003L`. Its wake
  stays coherent and its joint angles remain below `28.4 deg`, so the existing
  state-feedback oscillator, posterior lag, and far-field course steering are
  evidence-backed components to preserve.
- The prefill misses the `0.75L` capture circle by only `0.294L`. At closest
  approach the head is near `(9.65,8.69)L` and speed is about `0.85L/T`; the
  fish passes below the target rather than colliding or becoming unstable.
  Replay of the normalized body-frame guidance shows the course error growing
  to its `1.25 rad` limit and the turn command remaining approximately `+1`
  from `18T` through `21T`. This is not a sign-selection failure that supports
  another global steering gain. The controller has insufficient time to turn
  the already fast swimmer during terminal capture.
- The sampled mean-curvature and phase-compensated yaw-rate alternatives do
  not justify replacing the far controller: they approach only `5.323L` and
  `3.003L`, respectively. Inherited notes likewise warn against increasing the
  course gain after unchanged long-turn failures. The current `1.044L` near
  miss is the first evidence that broad route control works and that a
  terminal regime is now the narrower missing capability.
- Raw actions exceed the acceleration envelope through most sampled traces
  and joint speed reaches `260 deg/T`, while the near miss still carries high
  translational speed. A terminal cadence increase would therefore be poorly
  supported. A drive-relief schedule should instead reduce late command load
  while retaining nonzero propulsion and unchanged steering authority.

## One candidate mechanism

Keep the achieved-course servo and traveling-bend carrier exactly as the
far-field scaffold. Add one continuous approach-hold mechanism: between `4L`
and `1.25L`, smoothly reduce the state-feedback oscillator frequency toward a
bounded `0.72` floor while leaving its amplitude, posterior lag, and course
steering acceleration unchanged. The schedule depends only on normalized
distance, has no stage counter or route, and retains a traveling wave rather
than coasting.

Expected test: match the prefill until the last `4L`, then lower terminal speed
and raw oscillator acceleration enough that the already correct-sign course
servo has more response time to move the head the remaining `0.294L` into the
capture circle. Falsify the mechanism if closest approach regresses, the fish
stalls outside capture, alternating wake coherence collapses, early closure
changes before `4L`, or the same below-target pass and lower-boundary exit
remain.

## Bookshelf transfer record

bookshelf_consulted: true
source_domain: biological burst-to-cruise transitions and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve rhythmic propulsion during broad routing, then continuously relieve drive near capture so bounded steering can redirect and damp terminal slip
transferable_invariant: separate route acquisition from a measured-distance terminal regime while retaining nonzero propulsion and closed-loop steering
nontransferable_details: published gains, dimensional cadence, robot or species geometry, prescribed burst timing, exact vortex phases, and task-specific routes
policy_translation: use normalized `distance_L` to reduce only joint-state oscillator frequency over a bounded interval; preserve body-frame target-versus-course feedback and both-joint acceleration steering
falsification: reject if far-field closure changes, terminal wake or speed collapses, action remains persistently clipped without a closer pass, or the trajectory again passes below the target outside `0.75L`

## Non-CFD verification

- Contract calls at `8, 4, 3, 2, 1.25, 0.75L` returned two finite joint
  accelerations. The relief gate is exactly zero at and beyond `4L`, reaches
  one at `1.25L`, and keeps the frequency scale at or above `0.72`.
- Replaying the evaluated parent states—not fluid dynamics—produced exact
  parent/candidate action equality wherever distance was at least `4L`.
  Across the frozen trace, rows whose raw command exceeded the acceleration
  envelope fell from `6022` to `5888`; this checks schedule direction only and
  is not evidence of a new trajectory or capture.
- The no-CFD boundary check passed with only
  `candidate_target_policy.jl` changed under `solver/`.
