import com.mapr.db.spark._
val tweets=sc.loadFromMapRDB("/tmp/tweets")
tweets.count
tweets.select("screen_name","text").take(5).foreach(println(_))
