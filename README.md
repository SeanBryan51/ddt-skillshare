# ddt-skillshare

This repo uses git submodules. To clone the repository, run

```
git clone --recurse-submodules https://github.com/SeanBryan51/ddt-skillshare.git
```

## What is DDT?

DDT is a graphical debugger used for debugging parallelised programs.

Supports debugging C, C++, Fortran and Python (limited to Python `3.5` to `3.8` on Gadi, [ref](https://opus.nci.org.au/display/Help/Arm+HPC+Tools#ArmHPCTools-PythonProgramDebugging))

## Running DDT

See [the NCI opus documentation](https://opus.nci.org.au/display/Help/Arm+HPC+Tools#ArmHPCTools-DDT) on how to run DDT on Gadi.

**Note:** the instructions on NCI Opus are a bit out of date. ARM sold Forge (that includes DDT) to Linaro. So to get the latest version on Gadi: `module load linaro-forge/23.0.1`. And on the [Linaro website](https://www.linaroforge.com/downloadForge/), you can download a remote client for DDT which is faster than running through the X-client.

### Interactive Debugging

Interactive debugging is typically done via a VDI session or by submitting an interactive PBS job as it will require using the GUI. For the demo, we will use an interactive job.

```
cd demo_integrate_mpi
./build.sh # compile the executable
qsub -I -X debug.pbs
```

Note, you will need to have X11 forwarding enabled when ssh'ing onto Gadi.

After the interactive job starts, run:

```
./debug.pbs
```

This will launch the DDT debugger for the compiled executable.

**Stepping through a program**

Like most debuggers, DDT can:

- Play (continue execution)
- Pause execution
- Step through each line of execution
- Step in out functions

**Process groups**

When debugging programs which run multiple processes, DDT allows you to group processes together into process groups. This is useful if we only want to debug a subset of processes.

**Locals**

Shows the variables in the current context. Value of each variables across each process is shown qualitatively.

**Breakpoints**

Breakpoints can be set globally or per process group.

**Tracepoints**

Tracepoints log the value of a variable at a specific execution point. They can also be set globally or per process group.

**Evaluating variables**

The 'Evaluate' panel provides a way to modify variables in the debugger at runtime.

**Assembly Mode**

DDT's 'Assembly Mode' shows the assembly of the current source file.

**Memory debugging**

DDT provides some functionality for memory debugging. These include:

- Heap debugging
- Heap overflow/underflow detection
- Heap consistency checks
- Backtraces for memory allocations
- Current memory usage across processes (via Tools > Overall Memory Usage)
- Memory statistics (via Tools > Overall Memory Stats)

Note, memory debugging functionality must be enabled on start up.

See the [ARM MAP](https://developer.arm.com/documentation/101136/22-1-3/MAP/Get-started-with-MAP/Welcome-page) tool for more comprehensive memory profiling.

**Logbook**

To encourage planning when debugging.

### Offline Debugging

Offline debugging simply runs the program with DDT without a GUI. Once the program exits, DDT produces a debug report as a html file. This is often useful when the program is too computationally expensive to debug interactively.

Offline debugging can be configured either via command line arguments or by specifying a sesssion file.

In offline mode, breakpoints don't halt execution but dump the state of the program to the debug report.

**Creating a session file**

We can create a session file from an interactive debugging session by clicking File > Save Session.

Note, launching the interactive session does not require a large amount of resources as we only want to set  relevant breakpoints, etc.

**Running an offline debugging session with a session file**

The following command runs an offline a debugging session with a generated session file:

`ddt -offline --ddtsession=<session-file-name> mpirun -n <nproc> <prog>`

## Other General Notes:

- I recommend disabling optimisation flags when compiling for easier use.

## Resources:

- [Arm Forge User Guide](https://developer.arm.com/documentation/101136/22-1-3/DDT)

- [Debugging and Optimizing Parallel Codes with Arm Forge - Debugging and DDT](https://www.youtube.com/watch?v=FEqYrmPTdhM&ab_channel=ARCHER2HPC)
