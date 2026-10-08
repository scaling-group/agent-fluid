# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, and inertial moving-window transport. All capture with zero
  angle, rate, or applied-acceleration contacts. The strongest finite example
  is the assigned force-qualified parent (`solver_64a9b2cc44b2`), which reaches
  `0.748308L` at `25.8115T`, has mean distance `2.496011L`, and peaks at planar
  force/yaw moment `0.01896/0.01010`. The phase-rejected posterior example
  (`solver_2515fae158ed`) is the informative mechanism failure: it captures,
  but later at `25.9105T`, with mean distance `2.497000L`, and its `18--24T`
  mean normalized course error/projected miss are worse
  (`0.55184/1.79710L` versus the parent's `0.54411/1.77355L`).
- I inspected every combined keyframe sheet in both the top-down mid-plane
  vorticity/body row and the oblique body/Lambda2 row. Each fish visibly
  self-propels from rest, carries an orderly alternating wake, preserves
  compact three-dimensional vortices, and reaches the target through the same
  shallow late hook. There is no imposed advection, broad curl, boundary
  interaction, wake breakup, numerical instability, or moving-window-induced
  rotation. The force-qualified parent is marginally faster, while the
  posterior, yaw-moment, and combined load-aware variants remain in the same
  visual trajectory family; the images and metrics therefore support
  preserving the carrier, not increasing its drive.
- The current samples close the recent middle-course residual branch. All four
  traces are identical through `18T`; at `8/12/16T` each still has normalized
  course error about `0.753/0.744/0.543` and projected miss about
  `7.85/6.22/3.31L`. Between `18--24T`, posterior reaction, yaw-moment gating,
  velocity-normal-force gating, and their load-aware combination change mean
  course error only across `0.54411--0.55184` and mean projected miss across
  `1.77355--1.79710L`. Arrival spans only `0.099T`, crossing depth only
  `0.00031L`, and every sheet retains the same hook. The inherited logs likewise
  classify the preceding instantaneous-sideslip edit as phase-confounded and
  the later load gates as finite tie-breaks. Another middle residual, force
  threshold, posterior reaction half-cycle, or scalar authority increase is
  unsupported.
- The unresolved error precedes those gates. The inherited course/miss-triggered
  redirect improved arrival, but it did not improve early course acquisition:
  its projected miss remained `7.85/6.22L` at `8/12T`, worse than the sampled
  unredirected comparison's `7.17/6.03L`. A clean next test must therefore
  change how upstream curvature is distributed through a beat without copying
  a route, holding a binary instantaneous intercept, or revisiting static mean
  bend.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, posterior lag,
course/miss-triggered response-released redirect, target-line residual,
upstream posterior vectoring, middle force response, capture modulation,
coordinated acceleration projection, and angle/rate viability guards. Add one
upstream duty-ratio mechanism to the anterior carrier: when normalized
body-frame course error materially exceeds body bearing, translation is
observable and closing, and the redirect is released, smoothly reduce the
anterior restoring phase on the requested bend side and strengthen it on the
opposite side. Joint angle supplies phase, target/velocity geometry owns side,
and a continuous far-distance complement withdraws the mechanism at the
sampled middle-response boundary. This changes half-cycle residence,
not oscillator amplitude, global gain, a clock phase, or a fixed route.

The falsifiable expectation is a lower projected miss or normalized course
error by `8/12/16T` and visible upstream separation while retaining at least
the parent's capture and coherent two-view wake, zero actuator contacts, and
approximately its `0.01896/0.01010` load regime. Reject the transfer if the
early route remains identical, target-side residence does not change, the
redirect or posterior wave loses propulsion, arrival regresses, capture is
lost, or actuator/load exposure rises materially. The current worker cannot
claim the outcome because formal CFD occurs only after handoff.

bookshelf_consulted: true
source_domain: robotic-fish CPG steering and asymmetric flapping
source_mechanism: change the duty ratio of the requested bend-side half-cycle while retaining the rhythmic propulsive carrier
transferable_invariant: persistent body-frame route error may be converted into bounded asymmetric half-cycle residence without prescribing global phase or a route
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, clock phase, exact vortex phase, and task-specific trajectories
policy_translation: normalized body-frame target/course geometry and closing response gate a joint-angle-derived upstream restoring-phase skew in joint 1; joint 2 retains its state-feedback lag and all middle/terminal logic passes through
falsification: reject on unchanged 8--16T course response, lost or slower capture, incoherent wake, actuator contact, or peak force and yaw moment above the assigned-parent regime

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 65-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the candidate remained non-empty throughout the edit.
- A deterministic 54,675-state grid spanning both lateral reflections,
  negative/zero/positive closing response, far/middle/near target states,
  beyond-limit joint angles and rates, and both helpful and adverse loads
  remains finite and within the `30 rad/T^2` policy envelope. Paired reflected
  states have zero numerical command error.
- Re-evaluating the assigned parent and candidate on all 4,693 reconstructed
  parent-trace states changes 1,617 post-guard command pairs, including 1,119
  by more than `0.05 rad/T^2`; maximum separation is
  `4.45372 rad/T^2`. Every changed row is outside `4.5L`, and significant
  activation is confined to `0.9405--18.0015T` and
  `12.3392--4.9858L`. The candidate's peak frozen-state command is
  `29.64580 rad/T^2`, versus the parent's `29.65805 rad/T^2`, and all middle
  and capture-corridor commands pass through exactly. This establishes a
  material bounded upstream mechanism test, not CFD evidence of improvement.
- The required check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this ChatGPT account. Its three prescribed commands were
  therefore run directly: the material-guidance check, exact lightweight
  Julia contract check, and solver editable-boundary check all pass. The
  guidance check initially exposed two identical copied-parent markers in the
  rendered workspace `README.md`; removing only the duplicate entry restored
  an unambiguous assigned parent. No formal CFD was run.
