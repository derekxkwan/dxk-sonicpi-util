#wrapper to reduce typing
def tp_syncloop(loopname, syncer)
  live_loop loopname, sync: syncer do
    use_bpm get[:bpm]
    yield
  end
  end

def tp_loop(loopname)
  live_loop loopname do
    use_bpm get[:bpm]
    yield
  end
  end



def tp_thread
  in_thread do
    use_bpm get[:bpm]
    yield
    end
  end
