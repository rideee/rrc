# RRC - Rid's Run Commands

## My BASH dotty files

- Uses [oh-my-bash](https://github.com/ohmybash/oh-my-bash) completions.
- Uses [fff](https://github.com/dylanaraps/fff) file manager.
- Uses [ansi](http://github.com/fidian/ansi) ANSI Code Generator.
- Uses [fzf-marks](https://github.com/urbainvaes/fzf-marks) (if fzf is
  installed).

<hr>

## Installation

To start using rrc run these commands:

<pre>
  $ git clone https://github.com/rideee/rrc $HOME/.rrc
  $ echo '. $HOME/.rrc/init.bash' >> $HOME/.bashrc
</pre>

## Overwrite defaults

You can easily overwrite the default settings by adding your own files to the
usr.d directory. For example:

<pre>
  $ echo "PROMPT_COMMAND='rrc::ps1 simplify'" > $RRC_USR_DIR/custom-ps1.bash
</pre>

Source the init.bash again (you can use reload alias) and now the PS1
configuration from conf.d/general.bash will be overwritten, and bash prompt will
be simplified.
