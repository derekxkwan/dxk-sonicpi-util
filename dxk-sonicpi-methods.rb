#wrapper to reduce typing

def live_tploop(loopname, syncer)
  live_loop loopname, sync: syncer do
    use_bpm get[:bpm]
    yield
  end
  end
