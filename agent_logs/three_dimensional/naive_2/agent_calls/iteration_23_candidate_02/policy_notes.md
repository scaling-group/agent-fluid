# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance and its inherited scores show a mature capture
  lineage: `-0.118996` at the preceding parent step and `-0.113729` after
  lateral phase demodulation. The three supplied residualized policies are
  exact code and rollout repeats: all capture at `16.604496T`, with
  `1.998146L` distance integral and `0.743958L` final head distance.
- The informative ablation keeps raw lateral velocity and crossflow in the
  posterior route loop. It still captures, but later at `16.609995T`, with a
  worse `1.999656L` distance integral, `0.745621L` final distance, and score
  `-0.115560`. This controlled comparison supports preserving the fitted
  anterior-sway subtraction rather than retuning the carrier.
- All sampled diagnostics report `uniform_direct`, `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm snapshot. The evidence therefore matches the
  released still-water contract.

## Visual diagnosis

The combined sheets were read from release through capture in both views for
the repeated best policy and the raw-lateral ablation. In the top-down row,
both fish accelerate under their own joint motion, sweep left and downward on
the same target-crossing arc, and develop a strong alternating mid-plane wake;
there is no background advection or inherited wake at release. In the oblique
row, compact opposite-signed structures remain attached to the beating tail
and trail along the traveled path through the final approach. The ablation
does not expose a different wake failure: its geometry is visually nearly
identical, consistent with the small but repeatable scalar regression. Thus
the missing behavior is not propulsion or gross turn sign.

The residualized capture still approaches at about `1.1U`, reaches the
posterior speed boundary late in the trace, and has five sign reversals of the
phase-demodulated inertial target-line rate inside `3L`. The inherited analysis
measures mean absolute line-of-sight rate `0.2036/T` there, versus `0.0690/T`
from `3--6.5L` and `0.0274/T` beyond `6.5L`. The visible final arc and these
kinematics identify late target-line rotation as the narrow remaining defect;
they do not support wave relief, another static bend, or scalar carrier gain
tuning.

## Policy hypothesis

Preserve the demonstrated carrier, raw-course anterior center, lateral/yaw
phase demodulation, posterior half-cycle relief, and one-sided speed guard.
Estimate inertial line-of-sight rate from the already normalized body-frame
target and phase-demodulated translational velocity,
`-cross(target_body_L, directional_velocity_U) / |target_body_L|^2`. Feed a
bounded version forward to the desired physical yaw rate only through the
existing approach gate. This separates rotating target geometry from body yaw
without an external clock and asks the established yaw-response loop to follow
the target line rather than repeatedly chase its angle after it has moved.

The new channel must be exactly zero outside the existing `6.5L` approach
region, remain below the established yaw-request scale, and leave propulsion
amplitude unchanged. Falsify it if capture is lost; if the route or connected
wake changes before `6.5L`; if late line-rate reversals or distance cost do not
improve; or if joint contact, acceleration residence, effort, force, or moment
worsens relative to the repeated `-0.113729` parent.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal prey capture
source_mechanism: sensor-feedback residuals modulate a rhythmic locomotor carrier, with a separate near-target approach-hold response
transferable_invariant: preserve a productive traveling wave while a bounded target-response rate corrects terminal directional motion
nontransferable_details: published CPG gains, species kinematics, actuator timing, exact vortex phase, and source-task routes
policy_translation: derive normalized inertial line-of-sight rate from body-frame target and phase-demodulated velocity, then feed it into the existing two-joint yaw-response request only on approach
falsification: reject if the nominal capture or pre-approach wake is lost, late route oscillation persists, or actuator and load diagnostics worsen

## Non-CFD verification

The workspace contract state returns two finite accelerations. A direct module
comparison with the assigned parent gives bit-exact actions at `8L`, where the
approach gate is zero, while a `2L` synthetic approach state exercises a
different action. Reflecting every lateral target, velocity, flow, yaw, joint,
and joint-rate component negates both candidate accelerations to numerical
precision. These checks establish far-route isolation and reflection
equivariance only; they do not predict the pending CFD result.
