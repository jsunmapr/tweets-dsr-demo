import com.mapr.db.spark._
val tweets=sc.loadFromMapRDB("/tmp/tweets")
tweets.count
tweets.select("hashtags","text").take(5)
