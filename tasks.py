from invoke import task

@task
def buildlocal(ctx):
    ctx.run("docker build -t local/circleci-remote-docker:latest .")

@task
def testlocal(ctx):
    ctx.run("bash testlocal.sh")