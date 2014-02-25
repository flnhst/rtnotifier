
require 'terminal-notifier'
require 'rt/client'
require 'date'
require 'time'

rt_queues_to_monitor = []

File.open('queues', 'r') do |f|
  while line = f.gets
    rt_queues_to_monitor.push line.strip
  end
end

first_run = true
keep_running = true

puts "Starting loop..."

while keep_running do
  current_time = Time.now

  puts "Current time: " + current_time.to_s

  sleep(10)

  puts "Attempting connection..."

  rt = RT_Client.new
  
  puts "Connected!"

  puts "Time after: " + Time.now.to_s

  rt_queues_to_monitor.each do |queue|
    puts "Checking " + queue
    tickets = rt.list("Queue = '" + queue + "' AND (Status = 'new' OR Status = 'open')")
    
    tickets.each do |ticket|
      #puts ticket.inspect
      proper_ticket = rt.show(ticket[0])
      
      lastupdated = proper_ticket['lastupdated']
      
      dt = Time.parse lastupdated
      
      puts 'Ticket #' + ticket[0] + ': ' + dt.to_s
      
      if dt > current_time
        desc = proper_ticket['subject']
        url = rt.server + 'Ticket/Display.html?id=' + ticket[0]
      
        puts "Found new ticket, notifying!"
      
        TerminalNotifier.notify('Queue: ' + queue, :subtitle => desc, :sound => 'default', :open => url)
      end
      
    end
  end

  puts "Done checking queues, sleeping..."

  #keep_running = false
end

puts "Exiting"



