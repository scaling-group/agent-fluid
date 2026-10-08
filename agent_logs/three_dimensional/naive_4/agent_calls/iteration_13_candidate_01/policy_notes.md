# Response-conditioned terminal relief with narrow posterior speed headroom

## Visual and quantitative diagnosis recorded before the policy edit

- Every sampled rollout and the assigned-parent rollout use the required
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. I inspected both the top-down vorticity and
  oblique Lambda2 rows for the best-scoring sampled capture
  `solver_94565263e129`, the assigned solver parent
  `solver_29c7c83f8e3e`, and the inherited broad-headroom result
  `solver_2c247367fda3`. All are self-propelled: a coherent alternating wake
  forms by `4T`, remains attached to a strong posterior traveling bend through
  the turn, and leaves compact finite three-dimensional vortex structures
  through capture. There is no visible passive advection, wake collapse,
  boundary interaction, or instability. The sheets are too similar to rank
  the mechanisms visually, so trajectory and load histories decide the edit.
- The unguarded carrier-phase-residual baseline captures at `16.0435T`, scores
  `-0.058311`, spends `5.8%` of samples at the posterior speed limit and
  `22.7%` at the posterior acceleration limit, and has mean absolute posterior
  command `25.514 rad/T^2`. The assigned parent's narrow (`0.96`),
  dominance-checked wave-speed guard retains the same coherent wake and
  capture, lowers those figures to `5.6%`, `22.4%`, and
  `24.902 rad/T^2`, and improves score to `-0.057037`. It advances the `8L`
  crossing by `0.011T`, but delays `6/4/2L` and capture by
  `0.006/0.028/0.017/0.028T`; it is a small physical change, not a solved
  navigation improvement.
- The inherited broad `0.95` speed-headroom policy is the most informative
  relative failure with complete visuals. It removes posterior exact-speed
  residence (`5.8%` to `0%`) and lowers posterior acceleration-limit
  residence (`22.7%` to `20.8%`), yet delays every `8/6/4/2L` milestone to
  `9.268/11.275/13.244/15.230T`, captures only at `16.456T`, and regresses to
  `-0.073426`. The slightly lower force and moment histories and unchanged
  wake topology do not compensate for lost progress. Constraint cleanup must
  remain narrow and dominance checked; eliminating saturation is not itself a
  target-policy objective.
- The best sampled policy supplies a separate, localized positive mechanism.
  Releasing approach damping and wave reduction only while either raw or
  carrier-residual redirect duty remains high leaves all `8/6/4/2L`
  crossings equal to the baseline, retains the coherent wake, captures one
  step later at `16.049T`, but improves distance integral from `1.941006L` to
  `1.939780L` and score to `-0.056774`. Its effect begins only inside the
  closing-conditioned approach, whereas the assigned parent's speed guard
  acts on posterior joint state. Their observational gates and control roles
  are therefore separable enough for one compact compatibility test.

## Policy hypothesis

Preserve the assigned parent's evaluated `0.96` posterior speed guard,
pointwise sign-and-magnitude dominance check, anterior oscillator,
carrier-phase residual gate, raw redirect direction, mean-first posterior
allocator, one-sided opposing-lobe relief, approach gate, limits, and exact
boundary projection. Add only the sampled response-conditioned terminal
settle mechanism: continue using proximity plus measured closing to lower the
redirect onset, but multiply anterior approach damping and posterior approach
wave reduction by one minus the bounded maximum of raw and residual redirect
duty. Thus the near-target gait settles when course response is aligned and
recovers rhythmic authority while either observed route signal still requests
the strong turn. The posterior speed guard remains responsible for yielding
only outward wave action near its constraint, so recovered terminal rhythm
cannot erase mean curvature or bypass the evidenced headroom protection.

Expect the `8/6/4/2L` route and coherent wake to remain at least as strong as
the assigned parent, with terminal relief recovering part of its delayed
final approach and retaining the sampled distance-integral benefit. Falsify
the combination if pre-approach milestones regress, capture is lost or later
than the assigned parent, distance integral/score fall below both component
policies, posterior limit residence returns toward the unguarded baseline,
mean curvature is attenuated, or wake/load stability worsens. The new
candidate has no same-worker CFD evidence; only contract, symmetry, gate
locality, and fixed-trace effects may be claimed before downstream evaluation.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation under bounded actuation
source_mechanism: sensor feedback separates rhythmic propulsion authority from target-directed mean turning and near-target settling
transferable_invariant: reduce a locomotor carrier near the target only after measured course response is aligned, while yielding only the rhythmic component that consumes actuator headroom
nontransferable_details: published gains, dimensional frequencies, motor dynamics, species-specific envelopes, prescribed phases, exact vortex phases, and source-task routes
policy_translation: use bounded body-frame closing and raw/residual course-response gates to release approach damping and wave reduction, while the normalized posterior joint-speed gate continues to attenuate only outward wave acceleration
falsification: reject if early target progress, capture, coherent wake, load stability, or posterior headroom regresses relative to the evaluated component policies

## Non-CFD verification

- Exogenous replay on all `2,922` states of the assigned parent's evaluated
  trace changes `118` action rows, beginning at `15.2515T`; every change is at
  distance at most `1.6518L`. There are zero action differences before the
  owned `1.75L` approach boundary, so the compatibility edit is localized to
  the hypothesized terminal regime on inherited observations. Relative to the
  separately evaluated terminal-relief component, only `13` trace rows differ,
  isolating the retained narrow posterior speed guard.
- A deterministic `14,580`-state sweep across both joint angles and speeds,
  bearing, body-frame forward/lateral velocity, and target distance produced
  finite bounded actions with exact lateral-reflection equivariance. It also
  found zero differences from the assigned parent at or beyond the approach
  boundary. All `34` direct `params.FIELD` references are returned by
  `target_policy_params()`, with no unused returned controller fields.
- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Running its three prescribed commands
  separately passed the material-guidance check, lightweight Julia policy
  contract, and solver editable-boundary check. No CFD was run.
