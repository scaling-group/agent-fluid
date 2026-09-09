# Terminal corrective-half-cycle candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations and the assigned-parent evaluation report direct
  uniform initialization in still water, zero background velocity, no
  cylinders, and no prewarm. In both rows of the combined sheets, the sampled
  predicted-miss captures self-propel down-left on a nearly direct route behind
  a compact alternating mid-plane vorticity wake and localized oblique
  Lambda2 structures. The informative approach-relief failure also generates
  a wake, but curls into a strongly lateral posture and wrong-way route before
  `left_domain`; it reaches only `2.703L`, touches both `45 deg` joint stops,
  and peaks near `0.713/0.300` normalized planar force/moment. This is a
  controller/topology failure rather than advection, absent thrust, or flow
  initialization failure.
- The byte-identical prefilled predicted-miss policy captured twice at
  `15.983--15.994T` and `0.7472--0.7500L`; a response-released-pulse sibling
  captured at `16.016T`. Those direct routes keep peak normalized planar
  force/moment at `0.0332--0.0367/0.0166--0.0185`, joint angles below about
  `37.9 deg`, and the posterior traveling wave active through capture. These
  physical properties, the far-field route, and the unbraked carrier should
  be preserved.
- Repeat evidence rejects nominal capture as robust. In inherited evaluations,
  recovery-pulse, response-released-pulse, joint-rate sway-residual, and the
  assigned parent's joint-angle terminal-bearing phase separation all retained
  the low-load direct route but missed at `0.9952--1.2175L` and exited left.
  The assigned parent specifically reached `1.21754L` before `left_domain`, so
  removing an estimated carrier angle from terminal bearing did not enlarge
  the capture margin.
- At closest approach, the existing terminal request is already about
  `0.91--0.99` in those misses; another bearing or curvature gain would merely
  tune a saturated signal. The three sampled captures instead cross the
  `0.75L` boundary with anterior angle `phi1=0.636--0.661 rad`, close to its
  positive extreme, whereas the inherited misses pass at
  `phi1=0.338--0.504 rad` and usually leave that corrective side rapidly.
  Thus threshold crossing remains coupled to the anterior beat phase even
  though the slow route, wake, joints, and loads remain useful.

## Single policy hypothesis

Preserve the full sampled predicted-miss architecture, far-field
pursuit/course blend, posterior lag and pulse, mean bend, response handoff,
and acceleration envelope. Add one actuator mechanism only: during a
still-closing terminal intercept, use normalized body-frame terminal request
and observed anterior joint state to detect when the head joint is on the
requested side but moving away from it. Apply a small bounded acceleration on
the requested side to lengthen that useful corrective half-cycle. The gate
vanishes on the opposite joint side, while moving into the bend, after closing
alignment is lost, or outside the terminal neighborhood; the posterior carrier
is never braked.

This state-based duty-ratio hold should reduce reliance on a fortuitous head
sweep at the capture boundary while leaving the evidenced direct route and
traveling wake intact. Falsify it if the new evaluation does not capture, if
the `0.995--1.218L` lower/left pass persists, or if it produces `>40 deg`
joint dwell, a looping/boundary topology, loss of the compact alternating
wake, or planar force/moment materially above the sampled
`0.037/0.019` envelope.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: change corrective half-cycle duty ratio without suppressing the posterior traveling wave
transferable_invariant: when target error remains and the observed joint is departing a useful target-signed bend, briefly prolong that corrective half-cycle and release it continuously when the geometry or response changes
nontransferable_details: published duty ratios and gains, clock phase, robot linkage geometry, species kinematics, exact vortex phase, dimensional frequency, and task-specific routes
policy_translation: gate a bounded target-signed anterior acceleration by normalized body-frame terminal geometry, positive closing alignment, and the signs and scales of `phi[1]` and `phi_dot[1]`; leave the posterior joint carrier unchanged
falsification: reject if capture and closest approach do not improve together or if the direct route, compact wake, joint-angle reserve, low normalized loads, boundedness, or reflection equivariance degrades

The candidate's CFD result is not available in this worker and is not claimed
as evidence.
