# Bidirectional steering-residual allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and semantic `capture`.  The assigned v28 parent
  reproduces twice at `20.5315 T`, score `-0.29558`, and distance integral
  `2.18697 L`.  Two independently written v29 policies also reproduce exactly:
  both move only anterior target-steering acceleration rejected by the joint
  bound into posterior headroom and capture at `19.3105 T`, score `-0.21058`,
  and integral `2.09959 L`.  This is closed-loop evidence for residual
  allocation, not a parameter-name or packaging effect.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the strongest v29 rollout and the assigned v28 parent from release to
  capture.  Both fish visibly self-propel from quiescent water: compact startup
  structures become a coherent alternating posterior wake while the body
  follows one continuous target-signed arc.  V29 is already closer by
  `0.195/0.517/0.992/1.045 L` at `8/12/16/18 T`; its more separated late wake
  packets agree with faster motion rather than passive advection.  There is no
  semantic failure among the current four sheets.  The inherited informative
  failure is still the uncentered gait projection that missed by `0.0506 L`,
  curled away, and exited left at `30.9388 T`, so raw redirect geometry and
  subtraction of deliberate mean curvature remain protected.
- Metrics agree with the visual comparison.  Relative to v28, v29 raises
  mean/max speed from `0.628/0.894` to `0.665/0.931 L/T`, changes
  head/tail/any-joint acceleration-limit residence from
  `35.92/10.37/46.29%` to `34.18/8.20/42.35%`, preserves peak normalized
  planar force at `0.03056`, and changes peak normalized yaw moment only from
  `0.01525` to `0.01541`.  The route gain therefore does not come from more
  time at the componentwise bounds or a visibly disordered wake.
- A replay of the evaluated v29 algebra on its completed trajectory reconstructs
  logged joint acceleration with mean/max error `0.000089/0.0604 rad/T^2`.
  After the proven head-to-tail recovery, posterior steering remains clipped
  on `287/3511` states (`8.17%`), with mean absolute unmet residual
  `0.974 rad/T^2` on those states.  Every sampled remainder fits into
  same-direction anterior headroom; total recoverable and total unmet absolute
  residual are both `279.45 rad/T^2`.  This fixed-trajectory calculation is a
  feasibility diagnostic, not a closed-loop performance claim.

## One-candidate policy hypothesis

Promote the reproduced v29 carrier-first allocator and make its steering-only
recovery bidirectional.  Project each state-feedback carrier first, send unmet
anterior route steering to the posterior joint as already validated, then send
only posterior route steering still rejected by that joint into remaining
same-direction anterior headroom.  Never transfer carrier demand, alter the
normalized body-frame guidance, or enlarge either componentwise acceleration
bound.  When both route residuals fit, behavior is exactly v29; the new branch
acts only on the phase-complementary posterior-clipping states diagnosed above.

The expected outcome is to retain the coherent v29 route and capture while
realizing the remaining bounded target request, improving middle or late
closure without additional saturation.  Falsify the mechanism if capture is
lost or later than `19.3105 T`, distance integral exceeds `2.09959 L`, the
smooth target-signed arc becomes the inherited overshoot/reversal topology,
or speed, joint-limit residence, normalized force/moment, or 3D wake disorder
materially exceeds the evaluated v29 envelope.

bookshelf_consulted: true
source_domain: elongated-body swimming and residual CPG control for distributed robotic-fish turning
source_mechanism: preserve the posterior-lag propulsive rhythm while target-derived residual control uses phase-dependent authority across multiple bending joints
transferable_invariant: a persistent route residual rejected by one bounded joint may use same-direction headroom at the other joint without transferring or cancelling the rhythmic carrier
nontransferable_details: published gains, dimensional cadence, species or robot linkage leverage, exact vortex phase, clocked oscillator phase, and prescribed task routes
policy_translation: retain normalized body-frame v29 guidance and carrier-first projection, then recover only the final clipped posterior steering residual in available anterior acceleration before the same physical bound
falsification: reject if bidirectional residual recovery loses or delays capture, increases limit residence or loads, disrupts the alternating wake, or recreates the inherited near-miss and reversal

## Evidence boundary

All rollout results above are completed sampled CFD or inherited evidence.  The
bidirectional allocator is evaluated only after this worker exits; no
same-worker CFD result is claimed.
