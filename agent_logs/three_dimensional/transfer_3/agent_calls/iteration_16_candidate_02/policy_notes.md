# Candidate diagnosis and hypothesis

## Evidence read before editing

- The four sampled evaluations all satisfy the direct-uniform still-water
  contract: `U_infinity=[0,0,0]`, no prewarm, no cylinders, and moving-window
  storage only. All terminate in capture at `25.11852 T`; there is no failed
  rollout in the current sample. I therefore compared the best finite example
  (`solver_dccfc80981c7`) with the repeated weakest example
  (`solver_5b4d6d3993a2`/`solver_44ab37a6c1df`) and used the distinct
  adverse-force result (`solver_b102cbd60615`) to test the proposed cue.
- Both top-down vorticity and oblique Lambda2 sheets show self-propulsion on the
  same compact target-directed arc, not background advection. The fish forms a
  coherent alternating posterior wake by `5 T`, carries it continuously through
  the broad turn, and reaches the capture sphere without collision, exit,
  visible terminal thrashing, or loss of the three-dimensional wake. The
  sampled sheets provide no visual reason to change the outer oscillator,
  posterior lag, redirect geometry, or shared mean bend.
- The repeated v28 controller scores `-0.528103`, with mean/final distance
  `2.429108/0.746163 L`. Replacing its course-angle condition by a normalized
  constant-velocity predicted-miss corridor improves the sampled result to
  `-0.528077`, `2.429087/0.746135 L`, without changing the capture step, outer
  action extrema, joint extrema, or outer load extrema. The miss contracts
  monotonically from about `0.685 L` to `0.228 L` inside `1.6 L`, so this is an
  achieved-intercept response cue rather than new steering authority.
- Independently, vetoing the v28 course-supported release only while lateral
  force opposes target-side translation improves it to `-0.528086`,
  `2.429094/0.746145 L`. Recomputing that normalized cue from its recorded trace
  shows it is not dormant: it reduces support on 20 of 226 inside-`1.6 L`
  samples and fully vetoes four. On the best predicted-miss trace it overlaps
  an active intercept release on only nine samples, while support is fully
  restored at capture. This supplies a narrow independent veto rather than a
  second actuation mechanism.
- All sampled controllers retain zero inside-`4 L` commands above
  `30 rad/T^2`; their outer extrema are identical (`|q1|=0.7548 rad`,
  `|q2|=0.6620 rad`, lateral force `0.01547`, yaw moment `0.007995`). The
  candidate must preserve those bounds and exact pre-terminal behavior.

## Policy hypothesis

Use the best sampled predicted-miss corridor as the only geometric condition
on the inherited `3.5%` coupled terminal carrier release. Multiply that release
by the independently evidenced adverse-force support from the prefilled
candidate. Helpful and neutral force remain transparent; adverse force can only
withhold optional carrier authority. Preserve the captured oscillator,
posterior lag, redirect, mean-curvature equilibrium, response-settling gate,
crossflow support, closure support, joint coupling, and all limits unchanged.

This is falsified if the combined gate is dormant, affects commands before the
existing late response band, delays or loses capture, increases predicted miss,
recreates terminal oscillation or joint-stop dwell, increases force/moment
loads, or disrupts either view of the coherent outer wake. Because the new CFD
run occurs after this worker exits, no improvement is claimed here.

bookshelf_consulted: true
source_domain: wake interaction and adaptive swimming
source_mechanism: separate persistent target geometry from fast hydrodynamic response and avoid cancelling helpful lateral motion
transferable_invariant: preserve target-directed propulsion while allowing only a small bounded response to reject an adverse measured load
nontransferable_details: organized vortex-street phase, Karman-gait kinematics, species-specific motion, published gains, and source-task routes
policy_translation: normalized body-frame predicted miss permits the existing small paired terminal release; normalized target-opposing lateral force smoothly vetoes only that release
falsification: reject on inactive overlap, changed outer motion, slower or lost capture, larger terminal miss, renewed saturation, increased loads, or degraded wake coherence
