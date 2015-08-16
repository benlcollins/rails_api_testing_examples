# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Muppet.destroy_all
Muppet.create([
  {name: 'Kermit', image_url: 'http://img1.wikia.nocookie.net/__cb20141006114333/disney/images/9/98/Kermit-two1.jpg'},
  {name: 'Piggy', image_url: 'http://image.gala.de/v1/cms/oh/miss-piggy_4839287-ORIGINAL-original.jpg'},
  {name: 'Fozzie', image_url: 'http://img2.wikia.nocookie.net/__cb20120410231906/muppet/images/b/b5/Fozzie2.jpg'}
])