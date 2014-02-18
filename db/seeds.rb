# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



br1 = Brewery.create name:"Koff", year:1897
br2 = Brewery.create name:"Malmgard", year:2001
br3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create name:"Lager", description:"Lageria"
s2 = Style.create name:"IPA", description:"IPAa"
s3 = Style.create name:"Porter", description:"Porteria"
s4 = Style.create name:"Pale Ale", description:"Palea alea"
s5 = Style.create name:"Weizen", description:"Weizenia"

b1 = Beer.create name:"Iso 3", style_id:s1.id, brewery_id:br1.id
b2 = Beer.create name:"Karhu", style_id:s1.id, brewery_id:br1.id
b3 = Beer.create name:"Tuplahumala", style_id:s1.id, brewery_id:br1.id
b4 = Beer.create name:"Huvila Pale Ale", style_id:s4.id, brewery_id:br2.id
b5 = Beer.create name:"X Porter", style_id:s3.id, brewery_id:br2.id
b6 = Beer.create name:"Hefezeizen", style_id:s5.id, brewery_id:br3.id
b7 = Beer.create name:"Helles", style_id:s1.id, brewery_id:br3.id

u1 = User.create username:"user1", password:"User1", password_confirmation:"User1"
u2 = User.create username:"user2", password:"User2", password_confirmation:"User2"

bc1 = BeerClub.create name:"Vallilan hiiva", founded:1989, city:"Helsinki"

m1 = Membership.create user_id:u1.id, beer_club_id:bc1.id

r1 = Rating.create beer_id:b1.id, score:50, user_id:u1.id
r2 = Rating.create beer_id:b1.id, score:23, user_id:u2.id
r3 = Rating.create beer_id:b2.id, score:10, user_id:u1.id

