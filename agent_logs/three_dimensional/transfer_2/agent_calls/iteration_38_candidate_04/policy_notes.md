# Joint-local redirect allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts and the assigned parent's inherited hybrid
  satisfy the frozen contract: direct uniform `U_infinity=(0,0,0)` release,
  no cylinders or prewarm, finite moving-window transport, stable dynamics,
  and `capture`. The sample contains no failed termination, so the informative
  negative is a control-allocation tradeoff within one useful capture class.
- I inspected both rows of the combined keyframe sheets from release through
  capture for highest-scoring `solver_6dada5e7a98a`, lowest-scoring
  `solver_0e3ccca5bc77`, and inherited `solver_a4c7d10ae245`. In every case
  the fish self-propels from blank quiescent water along a shallow targetward
  arc. Alternating top-down caudal vorticity and compact oblique Lambda2
  structures remain coherent; there is no passive advection, collision, exit
  precursor, out-of-plane failure, or wake collapse. The views are too close
  to justify ranking by vortex prominence, so trajectory and actuator metrics
  determine the next mechanism.
- The sampled common full-demand preview is fastest at `15.604T` with
  `1.79354L` distance integral, but has `13.137L` head path, peak planar
  force/yaw moment `0.04226/0.02076`, and anterior/posterior residence above
  90% of the rate envelope `17.45/6.66%`. The carrier-only joint-selective
  preview is slower at `15.730T/1.80572L` but establishes the low-cost class:
  `12.848L`, `0.03558/0.01724`, and `17.10/5.77%`.
- The assigned parent's now-evaluated joint-selective full-demand hybrid
  retains the fast class at `15.593T/1.79516L` while improving on the common
  full-demand sample's path, load, and rate residence: `13.017L`,
  `0.03798/0.01853`, and `17.39/6.46%`. It therefore supports separating
  full-demand contact sensing from joint-local positive-carrier allocation,
  but does not fully retain the carrier-only parent's shortest-path/load class.
- In the inherited hybrid, the positive-work guards are joint-local, but an
  unfulfilled velocity-course redirect still uses the maximum of the two rate
  gates to attenuate both joints' outward carrier work and both reversal
  components. Thus an anterior steering/rate event can suppress posterior
  carrier authority even when the posterior joint has more rate margin. This
  remaining cross-joint coupling is the architecture target; prior evidence
  rejects another scalar onset, instantaneous load relief, same-sign-yaw
  release, and a hard distance-only handoff.

## One-candidate policy hypothesis

Start from the evaluated joint-selective full-demand hybrid, retaining the
corrected-sign body-frame target scaffold, distance/closing drive relief, full
velocity-course redirect, phase steering, posterior wave allocation,
carrier/steering decomposition, soft bounds, and public two-joint contract.
Make only redirect-driven carrier allocation joint-local: combine each joint's
own full-demand rate gate with the shared normalized unfulfilled-redirect
request, and use that result to govern only the same joint's outward carrier
work and response-conditioned reversal. Target-conditioned steering remains
outside the guard, and no parameter gain changes.

Expected evidence is retained capture, coherent wakes, and the inherited
`15.593T/1.79516L` fast class, with path, peak load, and rate residence moving
toward the carrier-only joint-selective class because an anterior bottleneck no
longer withdraws posterior rhythmic authority. Falsify if capture or early
milestones regress beyond the current spread; if path, planar force/yaw moment,
or either rate-residence fraction rises; if the posterior command becomes a
persistent near-limit substitute for anterior work; or if joint margin,
finite action, terminal course, or either wake view leaves the sampled useful
class. The candidate's CFD evaluation occurs only after this worker exits and
is not evidence claimed here.

bookshelf_consulted: true
source_domain: Lighthill-style reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: a posteriorly lagged traveling bend supplies reactive thrust while bounded observed-state feedback modulates rhythmic effort around maneuver demand
transferable_invariant: an anterior steering or actuator-envelope event should not suppress posterior rhythmic contribution when the posterior joint retains state-space margin
nontransferable_details: published gains, species-specific amplitude envelopes, dimensional cadence, clocked CPG phase, exact vortex phase, full-body waveforms, and task-specific coordinates or routes
policy_translation: combine normalized joint-local rate preview with the body-frame unfulfilled-redirect request, then attenuate only that joint's carrier work while preserving target-conditioned steering
falsification: reject if the local allocation fails to retain fast coherent capture while reducing path, load, and rate residence, or if it shifts persistent rate/load cost to the posterior joint
