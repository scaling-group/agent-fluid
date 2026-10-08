# Slip-phase posterior positive-work envelope

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the four sampled solver scores,
  observations, diagnostics, trajectories, policies, the assigned-parent
  guidance, and inherited worker notes and rollout. Every evaluated episode is
  a finite capture from direct uniform still water with
  `U_infinity=[0,0,0]`, no prewarm, no cylinders, and no boundary or numerical
  termination.
- I inspected all four sampled combined keyframe sheets and the inherited v32
  sheet, including their top-down mid-plane vorticity and oblique Lambda2 rows
  from release through capture. The scalar-leading v31 rollout and the
  informative inherited v32 regression both visibly self-propel from rest,
  form a coherent alternating reverse wake, retain compact three-dimensional
  posterior structures, and turn toward the target. Neither shows passive
  advection, reciprocal standing motion, wake breakup, or out-of-plane
  instability. The effectively unchanged wake topology makes terminal
  half-cycle allocation, rather than propulsion creation, the useful control
  distinction.
- The sampled v31 course-consensus posterior duty policy has the best completed
  mean-distance/score pair (`1.950346L/-0.064000`) and retains capture at
  `18.0125T`, but reaches the capture circle at only `0.1297` course alignment,
  `0.8077 rad/T` absolute yaw, and `0.8732U` target-normal speed. The sampled
  v26 one-sided slip-synchronous feathering improves final alignment/yaw/slip
  to `0.1728/0.6545 rad/T/0.8493U`, but regresses mean distance and score to
  `1.950469L/-0.064149`.
- The assigned parent's v32 unit-centered slip/phase duty redistribution does
  not combine those benefits. Relative to v26 it delays capture from
  `18.0125T` to `18.0235T`, worsens mean distance/score from
  `1.950469L/-0.064149` to `1.950735L/-0.064451`, widens center path/head
  cross-track from `13.2064L/0.7265L` to `13.2302L/0.7416L`, raises final
  target-normal speed from `0.8493U` to `0.8721U`, and lowers final alignment
  from `0.1728` to `0.1546`. Its lower final yaw (`0.5611 rad/T`) is not a
  joint terminal improvement. The inherited v33 phase-reset translation also
  regresses to `1.950805L/-0.064554` and a `13.2163L` path. Thus the observed
  slip/phase signal remains informative, but moving or amplifying the
  posterior target has now failed in three distinct forms.

## Single policy hypothesis

Start from the completed v31 scalar leader and preserve its odd body-frame
route controller, state-feedback anterior oscillator, posterior lag and
emphasis, course-consensus duty ratio, phase-consistent reserve, conserved
forward mean bend, half-cycle steering, and reversal-preserving rate governor.
Add one downstream actuator-allocation mechanism without changing the
posterior wave target: during only a moving, misaligned approach, combine
normalized target-normal velocity with normalized summed joint rate to select
the posterior half-cycle whose motion reinforces cross-course slip. On that
half-cycle, withdraw a bounded fraction only from posterior drive acceleration
that would increase the current posterior joint speed. Leave steering
acceleration, every reversal/deceleration, the opposing half-cycle, cadence,
mean bend, wave gain, and lag unchanged.

This separates the evidenced sensory selector from the repeatedly falsified
wave-target edits. The authority is exactly zero at and beyond `2.10L`, at
rest, at zero target-normal slip, at zero joint-rate phase, on the opposing
half-cycle, and on non-positive posterior drive work. Offline replay of the
selector on the completed v31 trace leaves all transit samples unchanged. It
is positive on `50.51%` of 394 approach samples, overlaps positive applied
posterior work on `26.14%`, and has mean/maximum authority
`0.10899/0.47229`; a `0.30` withdrawal bound therefore implies only a mild
replay-scale positive-work reduction. Under lateral reflection both signed
inputs and joint commands reverse, so selector magnitude and remaining work
authority are invariant. Expected evidence is v31-class closure and coherent
two-view wake with lower target-normal speed, yaw, cross-track, and posterior
limit residence. Falsify if transit output changes; capture, arrival, mean
distance, or path regress materially; reversal is weakened; pressure migrates
forward; slip/alignment/yaw and limit residence do not improve together; the
response does not reflect; or either wake row deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body reactive propulsion
source_mechanism: preserve the traveling rhythm and posterior lag while sensory phase feedback withdraws only actuator work that reinforces unwanted transverse motion
transferable_invariant: keep the propulsive wave target and full reversal authority, and modulate only positive posterior work on the observed half-cycle that reinforces target-normal slip
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phase, world coordinates, target location, capture radius, and task-specific routes
policy_translation: form a reflection-invariant gate from normalized body-frame target-normal velocity and normalized summed joint rate, then reduce only speed-increasing posterior drive acceleration during the established approach while leaving steering and reversals intact
falsification: reject if pre-approach output changes, capture or closure regresses materially, reversal is weakened, saturation migrates, terminal slip/alignment/yaw/path do not improve jointly, reflection fails, or either coherent wake view worsens

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its available
  checks directly gives `PASS` for guidance materiality and `PASS` for the
  solver editable boundary. The guidance check first found two identical
  assigned-parent markers in the rendered workspace `README.md`; removing
  only the duplicate made the parent comparison unambiguous.
- Julia is not installed, so the executable include/action probe cannot run.
  Deterministic static checks find one definition of each public function,
  resolve all 68 direct `params.FIELD` references among the 70 fields returned
  by `target_policy_params`, confirm balanced delimiters and a nonempty sole
  candidate, and find no explicit elapsed time, step count, randomness, file
  I/O, cylinder coordinates, target coordinates, or memorized route input.
- Algebraic checks bound the new positive-work multiplier to `[0.70,1.0]`,
  make it exactly one for every non-positive posterior drive-work command, and
  preserve selector magnitude and work authority under lateral reflection.
  Offline replay on the completed v31 trace gives the inactivity and activation
  figures stated above. These are contract and selectivity checks on completed
  evidence, not a claim about the pending CFD response.
