# agent-browser

**Source:** https://github.com/vercel-labs/agent-browser (Apache-2.0)

A browser the agent can drive from the command line: open pages, click, fill forms, take screenshots.

## Why I use it
- Claude can test a web app the way a user would, then show me the screenshot.
- It is faster and more reliable than having the agent fetch raw HTML.

## Install

```bash
npm install -g agent-browser
agent-browser install   # downloads Chrome the first time
```

Skill for Claude Code:

```bash
npx skills add vercel-labs/agent-browser
```
