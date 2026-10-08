# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance was read. No inherited `logs/optimize` artifact
  was present, so no absent candidate notes are being inferred.
- All four sampled evaluations used direct uniform still water
  (`U_infinity=[0,0,0]`), had no prewarm snapshot, and captured. The combined
  sheets for the strongest finite result and the most informative weak result
  were inspected in both rows. Top-down vorticity shows self-propelled approach
  behind a coherent alternating wake; oblique Lambda2 shows the same compact
  three-dimensional vortex train rather than background advection or a wake
  collapse. The paths and wakes are visually nearly coincident until terminal
  approach, so this iteration should preserve the carrier.
- The phase-demodulated course brake is the progress baseline: v24 captured at
  `23.8315T`, with mean distance `2.434073L`. Hard yaw/course consensus v25
  captured at `23.8590T` and mean `2.434115L`; yaw-selected dissipative direction
  v26 captured at `23.8535T` and mean `2.434214L`. Neither semantic variant
  materially reduced inside-`3L` yaw, cross-track speed, lateral force, or yaw
  moment from v24 (`1.684 rad/T`, `0.239U`, `0.01179`, `0.00640`).
- The blanket approach residual-allocation branch v23 was slower (`23.9250T`,
  mean `2.435081L`) but had the only consistent cleanup: inside-`3L` mean
  absolute yaw/cross-track/force/moment fell to `1.585 rad/T`, `0.227U`,
  `0.01109`, and `0.00599`, while posterior near-limit acceleration exposure
  fell from `18.62%` to `15.70%`. Because that sibling also omits v24's
  terminal posture, the cleanup cannot yet be attributed to allocation alone;
  layering pressure-gated allocation onto v24 is the required compatibility
  test rather than a claimed positive result.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG control with target-feedback residual commands
source_mechanism: preserve a rhythmic propulsive carrier and layer bounded target-derived residual authority only where feedback requires it
transferable_invariant: separate propulsion from steering authority, and condition their actuator sharing on normalized observed demand rather than a clock or route
nontransferable_details: published gains, oscillator timing, species-specific kinematics, duty ratios, exact vortex phases, and task-specific paths
policy_translation: retain the evaluated state-feedback traveling-wave carrier and body-frame course brake; near the target, smoothly reserve command headroom for the steering residual only when the unprojected component command approaches the acceleration envelope
falsification: reject if capture is lost, arrival or mean distance regresses to the blanket allocator, terminal yaw/load does not move toward v23, or joint-speed and acceleration exposure worsen

## Candidate hypothesis recorded before policy edit

The v24 course-directed terminal posture is retained because it is the sampled
progress winner. A continuous command-pressure gate will be added to v23-style
component-wise residual allocation. Distance supplies terminal relevance, while
the normalized magnitude of the unprojected carrier-plus-steering command
supplies evidence that allocation is actually needed. This should leave the
far and unsaturated v24 command essentially unchanged, avoid the blanket
allocator's propulsion cost, and recover part of v23's lower yaw/load and
posterior command exposure. The edit uses only joint state plus normalized
body-frame target/velocity feedback already in the contract; it adds no time,
world coordinates, mutable state, or case identity.
