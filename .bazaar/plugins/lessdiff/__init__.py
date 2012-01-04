#!/usr/bin/python
"""lessdiff - colourised bzr diff via a pager."""

import bzrlib.commands
import bzrlib.builtins
import pipes

class cmd_lessdiff(bzrlib.builtins.cmd_diff):
    aliases = ['ldi', 'ldif', 'ldiff']

    def run(self, **kwargs):
        import os, errno

        pipe1 = pipes.Pipe()

        pid = os.fork()
        if pid == 0:
            pipe2 = pipes.Pipe()

            pid = os.fork()
            if pid == 0:
                pipe1.producer()
                pipe2.consumer()

                try:
                    os.execvp('colordiff', ['colordiff'])
                except OSError, e:
                    if not hasattr(e, 'errno') or e.errno != errno.ENOENT:
                        raise

                # fall through to cat
                os.execvp('cat', ['cat', '-'])
                return

            pipe2.producer()
            pipe2.kill_stdin()
            bzrlib.builtins.cmd_diff.run(self, **kwargs)
            return

        pipe1.consumer()
        pager = os.environ.get('PAGER', 'less')
        os.execvp(pager, [pager, '-R', '-'])

bzrlib.commands.register_command(cmd_lessdiff)
