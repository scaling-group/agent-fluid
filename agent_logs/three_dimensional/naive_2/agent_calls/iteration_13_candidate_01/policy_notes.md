# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled rollouts confirm direct uniform still-water initialization
  (`U_infinity=0`) and finite self-propulsion. In both the top-down vorticity
  and oblique Lambda2 rows, the assigned distance-relief parent
  `solver_4482d3d05d9c` retains an alternating, tail-connected wake while
  translating leftward, but it drifts above the target and exits the upper
  boundary at `20.861T`. Its closest approach is `5.126L` at `17.347T`, still
  at `0.826U`; reconstructed acceleration near-limit residence is `70.3%`,
  with peak planar force `0.0345` and peak yaw moment `0.0178`.
- The most informative sampled response-aware failure,
  `solver_929554cd32fb`, also retains the organized carrier in both visual
  rows and reaches `4.530L` at `17.248T` with lower closest-approach speed
  (`0.725U`), near-limit residence (`59.3%`), peak planar force (`0.0306`),
  and peak yaw moment (`0.0157`). It nevertheless recedes to `6.035L` and
  repeats the upper-boundary exit at `21.725T`. The other two sampled
  posterior scheduling variants reach only `4.743--4.867L` and share that
  topology, so a coherent wake and reduced effort do not establish capture
  authority.
- Inherited completed logs and guidance identify the useful sign calibration:
  requested posterior curvature maps to opposite-sign physical yaw, with
  actual-minus-requested yaw feedback. That response mechanism reached
  `2.299L`, while its closest approach still had about `2.06L` lateral target
  separation and yaw opposing the request. A later inherited result reaches
  `2.169L` and improves final distance from `8.092L` to `7.727L`, but both
  remain uncaptured upper exits. This supports preserving response-calibrated
  approach control while demanding a post-closure-loss redirect rather than
  reducing the anterior carrier or adding another proximity-only relief.

## Candidate hypothesis

Use the inherited actuator-calibrated course-to-yaw response as the slow
posterior mean-curvature request and keep the complete anterior oscillator and
lagged posterior wave. Add one state-derived burst-redirect actuator: only
when distance is near, measured closure is lost, and yaw still opposes the
requested response, amplify the favorable posterior half-cycle and attenuate
the unfavorable half-cycle by equal bounded amounts. The modulation is
clock-free and its scale factor has unit mean over a symmetric beat; its
phase-correlated action creates a transient directional tail bias without a
static anterior bend or shedding the propulsive carrier. It should leave the
demonstrated approach inactive while closure is positive, then create a
targetward re-approach instead of the repeated upper exit.

bookshelf_consulted: true
source_domain: biological C-start redirect and robotic-fish asymmetric flapping
source_mechanism: response-gated burst curvature combined with half-cycle amplitude asymmetry
transferable_invariant: preserve the propulsive rhythm, infer beat side from joint state, and apply bounded asymmetric authority only while a large observed route error lacks the requested yaw response
nontransferable_details: species-specific C-start kinematics, published gains and duty ratios, dimensional frequencies, exact vortex phase, and prescribed routes
policy_translation: normalized distance and closing speed gate an actuator-calibrated yaw-response residual; posterior wave sign supplies beat phase, and only the second-joint target receives bounded equal amplification and attenuation that creates transient turn bias
falsification: reject if closest approach worsens beyond 2.299L, the coherent carrier or finite-load envelope is lost, near-limit residence rises materially above the response baseline, or the fish repeats the upper exit without capture, re-approach, or a more targetward terminal arc
