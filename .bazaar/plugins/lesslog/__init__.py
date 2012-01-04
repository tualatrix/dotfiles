#!/usr/bin/python
"""lesslog - bzr log via a pager"""

import bzrlib.commands
import bzrlib.builtins
import pipes

class cmd_lesslog(bzrlib.builtins.cmd_log):
    aliases = ['ll']
    def run(self, **kwargs):
        import os

        pipe = pipes.Pipe()

        pid = os.fork()
        if pid == 0:
            pipe.producer()
            pipe.kill_stdin()
            bzrlib.builtins.cmd_log.run(self, **kwargs)
        else:
            pipe.consumer()
            pager = os.environ.get('PAGER', 'less')
            os.execvp(pager, [pager, '-'])

bzrlib.commands.register_command(cmd_lesslog)
