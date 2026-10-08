# Power-matched guarded-work transfer candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The two byte-identical
  soft-envelope samples are one physical reference, not two independent
  confirmations. Their combined sheets and those of the prefilled and
  posterior-to-anterior variants were inspected from release through capture.
- In every top-down row, the fish advances while a regular alternating red/blue
  street lengthens behind the caudal region. The oblique rows retain compact,
  alternating three-dimensional Lambda2 structures through the terminal arc.
  Peak body speed is `1.383--1.395U`, whereas peak local flow is only
  `0.0315--0.0329U`; this is coherent self-propulsion, not moving-window or
  ambient advection. No sampled variant loses capture or wake coherence.
- The unguarded high-knee soft envelope is still the strongest route: it
  captures at `16.943T`, has mean distance `2.08985L`, and peaks at
  `0.03609/0.01766` planar force/yaw moment. Its mechanical defect is exact
  `260 deg/T` contact in `115/109` anterior/posterior samples. Both sampled
  high-onset reallocation variants remove exact contacts. The prefilled
  anterior-to-posterior variant captures at `17.053T`, has mean distance
  `2.09541L`, and scores `-0.21075`; the posterior-to-anterior positive-work
  variant captures at `17.060T`, improves mean distance to `2.09311L` and
  score to `-0.20865`, and lowers force to `0.03546` while remaining below
  `259.2 deg/T` on both joints.
- The inherited parent log provides the required baseline for interpreting
  that small difference: a narrow `0.94` positive-power guard without transfer
  captured at `17.115T` with mean distance `2.09800L`. Thus the sampled
  posterior-to-anterior transfer is a real semantic improvement over its
  guarded parent, but it has not recovered the unguarded route. Earlier
  replay evidence explains the direction: `96/109` posterior-limit samples
  have simultaneous positive-work anterior headroom, while none of the `115`
  anterior-limit samples has positive-work posterior reception. The remaining
  mismatch is that acceleration magnitude does not preserve even the
  normalized `phi_dot*phi_ddot` kinetic-power proxy: donor and receiver joint
  speeds differ strongly during these events.

## Single-candidate policy hypothesis

Start from the sampled posterior-to-anterior positive-work controller and
preserve its body-frame target/course feedback, zero-centered anterior
oscillator, posterior lag and steering reserve, C1 acceleration shoulder,
`0.94` directional speed guards, and posterior kinetic angle-margin
projection. Replace acceleration-magnitude reallocation with one bounded
power-matched transfer. When the posterior guard removes positive joint work,
and the anterior joint is already doing positive work, compute the dimensionless
command-level kinetic-power proxy from normalized joint speed times normalized
removed acceleration. Transfer the same retained fraction as an anterior
acceleration divided by normalized measured anterior speed. This is not a
torque or muscle-power model. A smooth normalized low-speed gate reaches full
authority at `0.20` of the receiver speed envelope, preventing a near-reversal
acceleration impulse; the high-speed headroom gate fades by `0.90`, before the
`0.94` anterior guard. The transferred residual itself is limited to `0.10` of
the owned acceleration envelope, and the existing `0.99` total-command reserve
remains the final cap.

This changes one mechanism rather than tuning carrier gains. It should keep
zero exact speed contact and both coherent wake views while matching the
quantity actually lost by the speed guard, improving on the sampled
`-0.20865`, `17.060T`, and `2.09311L` result. Falsify it if capture or
alternating shedding is lost, either speed limit is touched, score/arrival/mean
distance regresses, anterior angle grows materially beyond `26.92 deg`, raw
acceleration reaches the hard envelope, or loads exceed the unguarded
`0.0361/0.0177` reference.

```text
bookshelf_consulted: true
source_domain: robotic-fish feedback-modulated CPG control and classical reactive swimming
source_mechanism: preserve a coupled propulsive rhythm while bounded sensor feedback reallocates actuator-limited work into a phase-compatible channel
transferable_invariant: constrained propulsive work should move only into an already positive-work receiver with measured state headroom, and command-level accounting should include normalized joint speed rather than equate accelerations at different phases
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, linkage efficiencies, and task-specific routes
policy_translation: use normalized joint speeds and joint-state phase; convert a dimensionless posterior phi_dot*phi_ddot proxy into bounded anterior acceleration only inside a smooth receiver-speed window, while retaining body-frame target/course steering and the two-joint state-feedback carrier
falsification: reject if hard-speed contact returns, capture or the alternating three-dimensional wake is lost, route metrics fail to beat the sampled positive-work transfer, anterior angle or hard-envelope use grows materially, or force and moment exceed the soft-envelope reference
```

Formal CFD remains deferred to EvE; these are prior-evidence expectations, not
claims about this unevaluated candidate.
