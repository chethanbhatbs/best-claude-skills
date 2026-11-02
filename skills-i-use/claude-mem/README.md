# claude-mem

**Source:** https://github.com/thedotmack/claude-mem (Apache-2.0)

Gives Claude memory across sessions. It records what the agent does, compresses it, and feeds the useful parts back into the next session.

## Why I use it
- A new session already knows what I did yesterday, so I don't repeat context.
- I can search past work ("how did I fix X last time?") instead of digging through old chats.

## Install

```bash
npx claude-mem install
```

The installer asks you to sign in. To skip that, see the source README for the `--provider` flag.
