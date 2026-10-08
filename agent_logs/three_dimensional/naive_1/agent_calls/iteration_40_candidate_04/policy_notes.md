# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the policy edit

- All four sampled evaluations report direct uniform quiescent initialization
  with `U_infinity=[0,0,0]`, no instability, and capture. The assigned parent
  `solver_6062f0878b7b` is the strongest finite result: capture at
  `22.027504T`, mean distance `2.100432L`, and score `-0.206239`, versus the
  executable-equivalent velocity-phase samples at `22.154001T`,
  `2.105583L`, and `-0.210952`.
- The top-down sheets retain the same self-propelled S-route and coherent
  alternating street from release to capture. The parent's bend-phase
  selector is already ahead at `16T` (`3.946L` versus `3.972L`) and `20T`
  (`1.796L` versus `1.856L`), so its advantage is useful route allocation,
  not a looser final threshold sample.
- The parent also lowers mean action from `59.932` to `59.552`, terminal
  action inside `1.5L` from `46.393` to `46.197`, and peak normalized
  force/moment from `0.030897/0.015839` to `0.030199/0.015463`; posterior
  rate-cap occupancy is essentially unchanged (`6.41%` versus `6.37%`).
  This agrees with the inherited optimizer diagnosis that centered anterior
  bend is a more informative posterior-load phase than anterior velocity.
- The parent's combined sheet and `solver_33ad1bc593b3` have blank oblique
  rows, so they provide no new three-dimensional wake confirmation. The
  complete top-down and oblique sheets for `solver_d1fa01b2365d` and
  `solver_fb6f1126a48d` remain the applicable 3D bound: discrete Lambda2
  structures accompany the same alternating carrier and capture route.

## One candidate

The current posterior half-cycle envelope thresholds centered anterior angle
alone. A retrospective partition over both the best parent and the complete-
view `22.154001T` trajectory shows that a unit-normalized joint-state phase
projection using centered angle plus a small velocity quadrature separates
target-signed mean yaw moment more sharply. For the parent, the separation
increases from about `0.00855` at the pure angle axis to `0.00930`; for the
complete-view comparison it increases from `0.00885` to `0.00951`. The
candidate therefore changes only that phase sensor. It keeps the same smooth
half-cycle gate, posterior scale bounds, target-side sign, traveling carrier,
course loop, recovery allocation, reactive rudder, and terminal relief.

Expected result: better alignment of the existing posterior allocation with
the hydrodynamically useful part of the measured bend cycle should beat the
parent's `22.027504T/2.100432L/-0.206239` arrival, mean-distance, and score
bound without increasing the parent's action, saturation, force, or moment
envelopes or changing the visible route. Reject the translation if capture is
later, if the distance integral rises, if the alternating wake or S-route
changes materially, or if peak load or rate-cap occupancy grows.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: select a useful propulsive half-cycle from sensed oscillator phase and apply bounded posterior amplitude asymmetry
transferable_invariant: infer beat phase from normalized joint angle and velocity, then allocate steering within the rhythmic carrier instead of replacing it
nontransferable_details: published CPG gains, duty ratios, species or robot kinematics, exact vortex phases, and task-specific routes
policy_translation: replace the centered-angle-only posterior selector with a unit-normalized centered-angle/velocity phase projection while preserving every existing feedback path and authority ceiling
falsification: reject if the candidate fails to beat 22.027504T and 2.100432L or worsens the inherited route, two-view wake bound, action, saturation, force, or moment envelope
