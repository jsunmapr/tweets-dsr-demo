import org.apache.spark.sql.Row;
import org.apache.spark.sql.types.{StructType,StructField,StringType};
val sqlContext = new org.apache.spark.sql.SQLContext(sc)
val schema = StructType( List( StructField("text", StringType, true), StructField("screen_name", StringType, true) ))
val df = sqlContext.createDataFrame(tweets.map(tt => tt.text[String] +"\t"+ tt.screen_name[String]).map(tt => Row(tt.split("\t")(0), tt.split("\t")(1))), schema)

df.registerTempTable("tTBL")
val results=sqlContext.sql("select screen_name,text from tTBL").show()
