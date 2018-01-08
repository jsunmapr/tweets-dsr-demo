import com.mapr.db.spark._
val tweets=sc.loadFromMapRDB("/tmp/tweets")
tweets.select("screen_name","text").take(50).foreach(println(_))
System.exit(0)
