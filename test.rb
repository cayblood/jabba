require 'rubygems'
require 'xmpp4r'

include Jabber

jid = Jabber::JID.new("jabba@localhost")
client = Client.new(jid)

client.connect("marius",5222)
client.auth("password")

message = Message.new("carl@localhost","ZOMG")


image_payload = %Q(<p>Now<img src="data:image/gif;base64,R0lGODlhAQABAIABAP8AAP///yH+EUNyZWF0ZWQgd2l0aCBHSU1QACwAAAAAAQABAAACAkQBADs=" alt="Red dot"></p>)
# Create the html part
h = REXML::Element::new("html")
h.add_namespace('http://jabber.org/protocol/xhtml-im')

# The body part with the correct namespace
b = REXML::Element::new("body")
b.add_namespace('http://www.w3.org/1999/xhtml')

# The html itself
t = REXML::Text.new(image_payload, false, nil, true, nil, %r/.^/)

# "This is so <strong><span style='background: #003EFF; '><span style='font-size: large; '>COOL!!!</span></span></strong>. I can really do <strong>HTML</strong> now.", false, nil, true, nil, %r/.^/ )
b.add(t)
h.add(b)
message.add_element h

client.send(message)

puts "All good"