# RT Notifier

This notifies you using Mac OS X notification messages when a new RT ticket has appeared in a queue.

## Installation

Requires Ruby, RubyGem and the following RubyGem packages:

- terminal-notifier
- rt-client

## Configuration

1. Copy .rtclientrc-template to .rtclientrc
2. Edit the .rtclientrc file to your needs (server, username, password, cookies directory).
3. Make a file called 'queues' and put the name of every queue you want to monitor in there, one per line.

## Running

    ruby main.rb



