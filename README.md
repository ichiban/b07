# b07

A twitter bot that tweets random Japanese texts generated by Markov chain.
It stores words and twitter settings in Redis.

Type `bin/b07 -h` to see help.

## learning

From command line:

<pre>
$ bin/b07 learn '象は鼻が長い。'
</pre>

Or from file:

<pre>
$ cat ~/hey
隣の家に囲いが出来たんだってな。
へー、かっこいー。
$ bin/b07 load ~/hey
</pre>

## config

<pre>
$ bin/b07 config --consumer-key=CONSUMER_KEY \
                 --consumer-secret=CONSUMER_SECRET \
                 --oauth-token=OAUTH_TOKEN \
                 --oauth-token-secret=OAUTH_TOKEN_SECRET
</pre>

## tweet

<pre>
$ bin/b07 random
</pre>