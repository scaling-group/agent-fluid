# Axial-response-gated posterior-reinforcement candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and capture. Three samples share policy SHA-256
  `f915d466444cf8efad27707431c558749510254354be3998c294348dbb001f25`,
  trajectory SHA-256
  `fa8976da26f3a950dd8a5288e8e790e9e1c58a93292fb69fbbdb45545e339851`,
  and combined-sheet SHA-256
  `1d4288824d61d0cb2e513bb0bef6c914b4ccc9c20a87e19e8d2a8af188edc04b`.
  They reproduce capture at `15.977511T`, final/minimum distance
  `0.744402707L`, distance integral `1.928580797L`, 2,905 steps, 238 moving
  shifts, and score `-0.045506315`. The distinct assigned-parent control
  captures at `16.054371T`, `0.745845616L`, distance integral `1.929839552L`,
  2,919 steps, 239 shifts, and score `-0.046899933`. The new posterior
  speed-response branch is therefore a replicated semantic improvement, not
  a one-run scalar fluctuation.
- I inspected both combined sheets from release through capture. In both
  top-down rows, the release disturbance develops by `4T` into a coherent
  alternating lateral wake and the fish follows a smooth target-directed arc;
  it is self-propelled rather than advected by the zero background flow. In
  both oblique body/Lambda2 rows, compact paired caudal structures persist
  without wake collapse, collision, virtual-boundary exit, or out-of-plane
  instability. The stronger policy's route and terminal difference remain
  below sheet resolution, so the trace and metrics, not a visually dramatic
  vortex, establish the improvement. No failed-termination sheet is present
  in the current sample; inherited failures are used only as logged
  scalar/trajectory evidence.
- The completed CFD evidence falsifies the original startup-thrust
  interpretation. Relative to the assigned parent, the stronger policy delays
  the `8L/6L` milestones from `9.074996/11.044002T` to
  `9.091496/11.055001T`, leaves the `4L/2L` milestones unchanged at
  `12.919506/14.800513T`, and gains only on the later approach. It also raises
  mean absolute posterior command from `24.5845` to `25.4727 rad/T^2`, exact
  posterior acceleration-limit residence from `21.79%` to `22.58%`, and peak
  lateral force from about `0.03239` to `0.03334`. A stronger recovery gain or
  another speed onset would therefore be scalar tuning without evidence of
  better propulsion.
- The current trace exposes a response-conditioned alternative. Across the
  693 samples through `4.070T` where the speed-deficit gate is open, normalized
  body-forward hydrodynamic force is nonpositive on 216 samples (`31.2%`);
  those states have mean forward acceleration `-0.479 U/T` and `7.87%`
  posterior acceleration-limit residence. On the 230 samples (`33.2%`) with
  forward force at least `0.003`, mean forward acceleration is
  `+0.728 U/T` and posterior limit residence is zero. Force and forward
  acceleration correlate at `0.956` before `4T`. This does not prove that
  force causes future thrust, but it gives an observed, body-frame response
  signature for selecting which parts of the already bounded supplemental
  wave to test.
- Inherited pre-limit guards lowered pointwise limiting yet accumulated into
  slower routes. The new mechanism must therefore leave the base traveling
  wave, anterior oscillator, navigation, approach, terminal shaping, and
  exact-boundary projection unchanged. It may condition only the unevaluated
  physical role inside the already replicated supplemental posterior branch,
  and must be judged by milestones and capture as well as effort.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: reinforce a posterior traveling-wave increment only when measured axial hydrodynamic load indicates a propulsive response
transferable_invariant: preserve the anterior rhythm and base traveling wave while bounded body-frame response feedback selects when supplemental posterior authority reinforces forward motion
nontransferable_details: published thrust laws and gains, species-specific envelopes, dimensional frequencies, exact Strouhal values, exact vortex or tail phase, source force scales, clock-defined bursts, and task-specific routes
policy_translation: retain the evaluated speed-deficit and approach envelope, but smoothly allocate only its feasible posterior-action difference from normalized body-forward force; no authority-increasing increment is added for nonpropulsive force, any sampled unloading effect is retained, and the full existing command is recovered after the evidenced positive-response scale
falsification: reject if early distance milestones fail to advance, the coherent alternating two-view wake changes adversely, capture or distance integral regresses, posterior limiting or lateral load does not improve, or the gate merely reproduces a clamp-equivalent trajectory

## One candidate hypothesis

Keep the sampled `f915d466...f25` controller intact except for one new
closed-loop allocation mechanism. The existing low-forward-speed and
outside-approach envelope still decides where a posterior-wave increment is
eligible. Within that envelope, normalized body-forward hydrodynamic force
selects whether the authority-increasing action difference is productive: its
weight is zero at nonpositive force, rises with a smooth cubic transition, and
reaches the existing boosted endpoint at `0.003`. If the evaluated boost
instead unloads the base request, retain that lower-demand action regardless
of force sign. Non-finite force safely removes only the authority increase.
The base posterior wave is never gated, so release can develop a response and
every established steering and terminal action remains available.

This is a response-feedback mechanism rather than a recovery-gain retune. Its
falsifiable expectation is that concentrating the already successful
supplemental wave on measured propulsive response will advance at least one of
the previously delayed `8L/6L` milestones and retain the later capture gain,
while reducing acceleration-limit residence or lateral load. A better effort
metric without milestone/distance-integral benefit is a failure under the
inherited guard evidence. Formal CFD remains post-exit and no outcome for this
candidate is claimed here.

## Non-CFD verification after the edit

- The candidate SHA-256 is
  `4bb2db972e74a3116167175c3d219314dbef8ddcd8ff24ce652fabc7c3353d46`.
  Static schema validation resolves all 52 direct `params.FIELD` references
  against exactly 52 fields returned by `target_policy_params()`, with no
  missing or unused field. The lightweight Julia policy call returns two
  finite accelerations.
- An initial tail-target-level realization of the same force gate was rejected
  during verification because removing a wave term that cancelled mean
  acceleration created four new posterior limit hits on reconstructed sampled
  states. The finalized policy instead computes the proven base and evaluated
  boosted feasible posterior commands, interpolates only their action
  difference, and retains the evaluated command whenever it is the unloading
  endpoint. This audit-driven refinement remains the one response-gating
  mechanism; it adds no second sensor or controller role.
- A deterministic 20,000-state endpoint sweep confirms that normalized
  forward force at or above `0.003` reproduces the evaluated
  `f915d466...f25` action exactly. At nonpositive force, the policy selects the
  lower-magnitude base or evaluated endpoint; partial force remains inside
  their convex interval and never exceeds the evaluated command magnitude.
  The sweep exercises 564 genuinely partial actions.
- A separate 20,000 paired-state sweep across target side and distance,
  body-frame forward/lateral velocity, axial/lateral force, bearing and yaw
  response, and joint phase returns finite bounded commands with zero lateral
  reflection error. Non-finite axial force also returns finite action by
  dropping only the new authority-increasing branch.
- Counterfactual evaluation on reconstructed states from one of the three
  byte-identical sampled-best traces changes 219 posterior commands only,
  over `0.0825-3.6630T`. Anterior action is exactly unchanged; maximum and mean
  posterior differences are `6.2798` and `1.4219 rad/T^2`, no changed command
  has larger magnitude than the evaluated command, and no new acceleration
  limit hit appears. This establishes feasible, non-clamp-equivalent support
  but does not predict the unevaluated closed-loop hydrodynamic response.
- The configured checker was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account. Its prescribed guidance-materiality,
  lightweight Julia contract, and solver editable-boundary checks were run
  directly and pass after removing only the duplicated assigned-parent marker
  from the rendered workspace `README.md`. No CFD was run.
