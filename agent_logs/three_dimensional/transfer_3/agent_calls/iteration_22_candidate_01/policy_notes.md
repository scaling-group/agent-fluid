# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations use direct uniform still-water initialization
  (`U_infinity = (0,0,0)`), remain finite, and terminate by capture. There is
  therefore no current-cohort failure sheet; the informative contrast is the
  slowest capture, while inherited guidance supplies the prior high-pass and
  route-loss failures.
- In both the fastest actuator-consistent sheet and the slowest headroom-
  allocated sheet, the top-down row shows self-propelled target progress with
  a coherent alternating wake from release through capture. The oblique row
  shows persistent three-dimensional Lambda2 structures behind the tail. The
  fish is neither passively advected nor losing propulsion during the turn;
  the late route response, not wake creation, separates the candidates.
- Same-side actuator-consistent phase recruitment is the strongest sampled
  variant: capture at `18.6725T`, score `-0.133625`, and mean score distance
  `2.02129L`. The assigned-parent rising-flank lead captures at `18.7880T`
  with score `-0.139997` and mean distance `2.02833L`; current-demand gating
  captures at `18.7990T`, and pure headroom allocation at `18.8320T`.
- The speed gain is not a load reduction. The actuator-consistent run has
  action RMS `24.95/28.85 rad/T^2`, posterior limit occupancy `76.11%`, and
  force/moment RMS `0.01350/0.00703`, versus `24.73/28.75`, `75.38%`, and
  `0.01333/0.00694` for the assigned parent. It remains below the inherited
  failed-branch bounds of `76.4%` posterior occupancy and
  `0.01574/0.00810` force/moment RMS. Local-flow RMS is `0.01809U`, agreeing
  with the visual diagnosis of self-generated propulsion in quiescent water.

## Policy hypothesis

Use the sampled actuator-consistent controller unchanged as the one candidate
so the next evaluation is a meaningful same-hash robustness replicate. Retain
the response-reversing half-cycle carrier and coefficient-norm-preserving tail
phase rotation, but recruit phase only when current unclipped posterior demand
and the previous feasible posterior action stress the same actuator side. This
one-step state feedback suppresses premature rising-flank prediction and beat-
reversal recruitment without introducing time, route memory, or scalar-only
gain tuning.

Falsify the selection if the new evaluation loses capture, breaks either wake
view's coherence, fails to remain earlier than the inherited
`18.931--19.052T` half-cycle replicate band, or exceeds `76.4%` posterior
occupancy or `0.01574/0.00810` force/moment RMS. A repeat inside those bounds
supports persistence-gated phase recruitment; it does not establish robustness
to stronger ambient disturbance.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation
source_mechanism: sensor feedback recruits bounded phase and asymmetric-flapping changes around a propulsive rhythm
transferable_invariant: preserve a traveling bend and modulate posterior phase from observed actuator and turn-response state rather than an external clock
nontransferable_details: published gains, oscillator frequencies, robot geometry, species kinematics, exact vortex phase, and task routes
policy_translation: normalize current posterior demand and previous feasible action by the acceleration limit; use their positive signed product to gate bounded reflection-equivariant tail-phase rotation
falsification: reject if capture or coherent propulsion is lost, arrival leaves the inherited successful band, or posterior occupancy and force/moment exceed the failed-branch bounds
