import os, sys

class Pipe:
    def __init__(self):
        self.read, self.write = os.pipe()

    def kill_stdin(self):
        # Make sure we don't eat our own output
        null = open('/dev/null')
        os.dup2(null.fileno(), sys.stdin.fileno())

    def producer(self):
        # Set stdout to go down the pipe
        os.dup2(self.write, sys.stdout.fileno())
        os.close(self.write)

        # Don't need the read pipe here
        os.close(self.read)

    def consumer(self):
        # Don't need the write pipe here
        os.close(self.write)

        # Set stdin to come from the pipe
        os.dup2(self.read, sys.stdin.fileno())
        os.close(self.read)
