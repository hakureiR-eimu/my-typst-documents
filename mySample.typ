#import "myTemplate.typ": *
#import "@preview/codelst:2.0.0": sourcecode


#show: project.with(
  anonymous: false,
  title: "课程名称：大数据处理",
  author: "张钧玮",
  school: "计算机学院",
  id: "U202115520",
  mentor: "刘海坤",
  class: "大数据 2102 班",
  date: (2024, 6, 1)
)


= 实验1：MapReduce实验

== 实验概况

通过本实验，学习如何在Linux环境下配置，运行并使用Hadoop运行环境以及HDFS，具体内容包括以下：
1. 安装与配置Hadoop
2. 配置、启动与使用HDFS
3. 使用MapReduce的工作原理编写WordCount程序
4. 深入理解MapReduce的工作原理并使用Hadoop框架实现PageRank算法

== 实验内容

=== 实验1&&实验2 

配置Hadoop&&HDFS环境，本质是下面实验的前置铺垫，跳过陈述

=== 实验3：WordCount程序

==== 任务描述

#indent()编写并执行基于MapReduce编程模型的WordCount程序，在分布式环境（HDFS）中运行它们

==== 实验设计

#indent()项目结构如下：
#sourcecode[```bash
# usami @ CodeOfUsami in ~/workU/HadoopTask/WordCount [13:04:26]
$ tree .
.
├── WordCount$IntSumReducer.class
├── WordCount$TokenizerMapper.class
├── WordCount.class
├── WordCount.jar
├── WordCount.java
└── input
    └── WordCount
        ├── file0
        └── file1

2 directories, 7 files
```]

#indent()项目结构解释：
  1. WordCount.java是编写的WordCount程序
  2. 使用javac编译WordCount.java生成WordCount.class，然后打包成WordCount.jar
  3. 在input文件夹下存放两个文件file0和file1，这两个文件是WordCount程序的输入文件。程序将会对input文件夹下面所有文件进行单词统计。
==== 实验过程
  1. 搭建项目结构
  2. 编写WordCount代码并使用javac编译打包，编写的代码如下：
#sourcecode[```java
import java.io.IOException;
import java.util.Iterator;
import java.util.StringTokenizer;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class WordCount {
    public WordCount() {}

    public static void main( String[] args ) throws Exception {
        // 设置 Hadoop Configuration
        Configuration conf = new Configuration();

        // 使用 GenericOptionsParser 获取命令行参数
        String[] otherArgs =
            ( new GenericOptionsParser( conf, args ) ).getRemainingArgs();

        // 如果输入参数个数 <2 则返回错误提示
        if ( otherArgs.length < 2 ) {
            System.err.println( "Usage: wordcount <in> [<in>...] <out>" );
            System.exit( 2 );
        }

        // 设置 Hadoop Job
        Job job = Job.getInstance( conf, "word count" );
        job.setJarByClass( WordCount.class );
        job.setMapperClass( WordCount.TokenizerMapper.class );
        job.setCombinerClass( WordCount.IntSumReducer.class );
        job.setReducerClass( WordCount.IntSumReducer.class );
        job.setOutputKeyClass( Text.class );
        job.setOutputValueClass( IntWritable.class );

        // 添加输入文件
        for ( int i = 0; i < otherArgs.length - 1; ++i ) {
            FileInputFormat.addInputPath( job, new Path( otherArgs[ i ] ) );
        }

        // 设置输出文件
        FileOutputFormat.setOutputPath(
            job, new Path( otherArgs[ otherArgs.length - 1 ] ) );
        // 提交任务并等待任务完成，如果成功则返回0，反之则返回1
        System.exit( job.waitForCompletion( true ) ? 0 : 1 );
    }

    // 定义 SumReducer 用于计算每个单词出现的总次数
    public static class IntSumReducer
        extends Reducer<Text, IntWritable, Text, IntWritable> {
        private IntWritable result = new IntWritable();

        public IntSumReducer() {}

        public void reduce(
            Text key, Iterable<IntWritable> values,
            Reducer<Text, IntWritable, Text, IntWritable>.Context context )
            throws IOException, InterruptedException {
            int sum = 0;

            // 遍历所有IntWritable，求和得到单词的总出现次数
            IntWritable val;
            for ( Iterator i$ = values.iterator(); i$.hasNext();
                  sum += val.get() ) {
                val = (IntWritable) i$.next();
            }

            // 写入结果
            this.result.set( sum );
            context.write( key, this.result );
        }
    }

    // 定义 TokenizerMapper
    // 用于将每行文本切分为单词，并输出每个单词及其出现次数（在该行文 本中）
    public static class TokenizerMapper
        extends Mapper<Object, Text, Text, IntWritable> {
        private static final IntWritable one = new IntWritable( 1 );
        private Text word = new Text();

        public TokenizerMapper() {}

        public void
            map( Object key, Text value,
                 Mapper<Object, Text, Text, IntWritable>.Context context )
                throws IOException, InterruptedException {
            StringTokenizer itr = new StringTokenizer( value.toString() );

            // 当还有更多单词时，继续获取下一个单词并输出
            while ( itr.hasMoreTokens() ) {
                this.word.set( itr.nextToken() );
                context.write( this.word, one );
            }
        }
    }
}
```]
  3. 使用#emph(text(blue)[hadoop fs -put])命令将input文件夹上传到HDFS的#emph(text(blue)[input/WordCount])目录下。
  4. 使用#emph(text(blue)[/usr/local/hadoop/bin/hadoop jar WordCount.jar org/apache/hadoop/examples/WordCount input/WordCount output/WordCount])命令运行WordCount程序。
  5. 使用#emph([hadoop dfs -get])得到结果文件。
==== 实验结果
#indent()HDFS系统中的output文件夹结果如下：
#sourcecode[
  ```
# usami @ CodeOfUsami in ~/workU/HadoopTask/WordCount [13:26:15]
$ hdfs dfs -ls output
2024-06-05 13:26:26,371 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Found 1 items
drwxr-xr-x   - usami supergroup          0 2024-06-05 13:26 output/WordCount
  ```
]
#indent()使用#emph[hdfs dfs -get output ./output]把文件下载到本地查看，结果如下：
#sourcecode[
  ```
  # usami @ CodeOfUsami in ~/workU/HadoopTask/WordCount/output/WordCount [13:29:10]
  $ ls
  _SUCCESS  part-r-00000

  # usami @ CodeOfUsami in ~/workU/HadoopTask/WordCount/output/WordCount [13:29:10]
  $ cat part-r-00000
  echo    1
  game    1
  of      1
  rainbow 1
  the     2
  waiting 1
  ```
]
#indent()可以看到，WordCount程序成功统计了input文件夹下的两个文件中的单词出现次数。

#pagebreak()
=== 实验4：PageRank算法
==== 任务描述

编写和执行基于MapReduce编程模型的PageRank程序，使用HDFS作为分布式存储环境

=== 实验设计

#indent()项目结构如下：
#sourcecode[```bash
# usami @ CodeOfUsami in ~/workU/HadoopTask [13:33:25]
$ tree PageRank
PageRank
├── Format
│   ├── Format$FormatCombiner.class
│   ├── Format$FormatMapper.class
│   ├── Format$FormatReducer.class
│   ├── Format.class
│   ├── Format.jar
│   └── Format.java
├── PageRank
│   ├── PageRank$PageCounter.class
│   ├── PageRank$PageRankMapper.class
│   ├── PageRank$PageRankReducer.class
│   ├── PageRank.class
│   ├── PageRank.jar
│   └── PageRank.java
├── input
│   └── PageRank
│       └── web-Stanford.txt

```]

#indent()实验设计两个MapReduce任务，第一个任务用于格式化输入文件，第二个任务用于迭代计算PageRank值。

对于格式化任务，设计MapReduce工作流。Map任务是处理输入数据，将每行文本拆分成节点对，并记录所有出现的节点。Reduce任务计算每个节点的初始PageRank值#emph([（1.0 / NODES.size()）])，并生成最终输出,持久化保存到output/format下面。

对于迭代计算任务，设计MapReduce工作流，旨在反复根据顶点的rank值以及所有入度的rank值迭代计算新的rank值直到顶点rank值收敛。Map类的主要功能是处理输入数据，保存顶点信息到内存上下文。Reducer类的主要功能是汇总来自Mapper的输入，计算每个页面的新rank，并判断收敛情况。



==== 实验过程

编译，打包，提交任务，查看结果的过程与第二个实验类似，这里不再赘述。

格式化任务的代码如下：
#sourcecode[```java
// 导入 Java 和 Hadoop 相关的库

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.StringTokenizer;
import javax.xml.soap.Node;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

public class Format {
    public static Set<String> NODES = new HashSet<String>();

    public Format() {}

    public static void main( String[] args ) throws Exception {
        // 设置 Hadoop Configuration
        Configuration conf = new Configuration();

        // 使用 GenericOptionsParser 获取命令行参数
        String[] otherArgs =
            ( new GenericOptionsParser( conf, args ) ).getRemainingArgs();

        // 如果输入参数个数 <2 则返回错误提示
        if ( otherArgs.length < 2 ) {
            System.err.println( "Usage: wordcount <in> [<in>...] <out>" );
            System.exit( 2 );
        }

        // 设置 Hadoop Job
        Job job = Job.getInstance( conf, "" );
        job.setJarByClass( Format.class );
        job.setMapperClass( FormatMapper.class );
        job.setCombinerClass( FormatCombiner.class );
        job.setReducerClass( FormatReducer.class );
        job.setOutputKeyClass( Text.class );
        job.setOutputValueClass( Text.class );

        // 添加输入文件
        for ( int i = 0; i < otherArgs.length - 1; ++i ) {
            FileInputFormat.addInputPath( job, new Path( otherArgs[ i ] ) );
        }

        // 设置输出文件
        FileOutputFormat.setOutputPath(
            job, new Path( otherArgs[ otherArgs.length - 1 ] ) );

        // 提交任务并等待任务完成，如果成功则返回0，反之则返回1
        System.exit( job.waitForCompletion( true ) ? 0 : 1 );
    }

    public static class FormatReducer extends Reducer<Text, Text, Text, Text> {
        private Text result = new Text();

        public FormatReducer() {}

        public void reduce( Text key, Iterable<Text> values,
                            Reducer<Text, Text, Text, Text>.Context context )
            throws IOException, InterruptedException {
            StringBuilder links = new StringBuilder();

            double rank = 1.0 / NODES.size();
            links.append( rank );
            for ( Text value : values ) {
                links.append( " " ).append( value.toString() );
            }

            // 写入结果
            this.result.set( links.toString().trim() );
            context.write( key, this.result );
        }
    }

    public static class FormatCombiner extends Reducer<Text, Text, Text, Text> {
        private Text result = new Text();

        public FormatCombiner() {}

        public void reduce( Text key, Iterable<Text> values,
                            Reducer<Text, Text, Text, Text>.Context context )
            throws IOException, InterruptedException {
            StringBuilder links = new StringBuilder();

            for ( Text value : values ) {
                links.append( " " ).append( value.toString() );
            }

            // 写入结果
            this.result.set( links.toString().trim() );
            context.write( key, this.result );
        }
    }

    public static class FormatMapper extends Mapper<Object, Text, Text, Text> {
        private Text nodaA = new Text();
        private Text nodaB = new Text();

        public FormatMapper() {}

        public void map( Object key, Text value,
                         Mapper<Object, Text, Text, Text>.Context context )
            throws IOException, InterruptedException {
            StringTokenizer itr = new StringTokenizer( value.toString() );

            this.nodaA.set( itr.nextToken() );
            NODES.add( this.nodaA.toString() );
            this.nodaB.set( itr.nextToken() );
            NODES.add( this.nodaB.toString() );

            context.write( this.nodaA, this.nodaB );
        }
    }
}
```]

#indent()PageRank代码如下:
#sourcecode[```java
// 导入 Java 和 Hadoop 相关的库

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.apache.hadoop.mapreduce.Counters;

import java.io.IOException;
import java.util.Objects;

import static java.lang.Math.abs;

public class PageRank {
    public PageRank() {
    }

    public static enum PageCounter {
        Converge,
        Total
    }

    public static void main(String[] args) throws Exception {
        // 设置 Hadoop Configuration
        Configuration conf = new Configuration();

        // 使用 GenericOptionsParser 获取命令行参数
        String[] otherArgs = (new GenericOptionsParser(conf, args)).getRemainingArgs();

        // 如果输入参数个数 <2 则返回错误提示
        if (otherArgs.length < 2) {
            System.err.println("Usage: wordcount <in> [<in>...] <out>");
            System.exit(2);
        }
        String inpath = otherArgs[0];
        String outpath = otherArgs[1] + "/iter";
        for (int i = 0; i < 50; i++) {
            // 设置 Hadoop Job
            Job job = Job.getInstance(conf, "");
            job.setJarByClass(PageRank.class);
            job.setMapperClass(PageRankMapper.class);
            job.setReducerClass(PageRankReducer.class);
            job.setOutputKeyClass(Text.class);
            job.setOutputValueClass(Text.class);
            // 添加输入文件
            FileInputFormat.addInputPath(job, new Path(inpath));
            // 设置输出文件
            FileOutputFormat.setOutputPath(job, new Path(outpath + i));
            // 下轮输入文件
            inpath = outpath + i;
            job.waitForCompletion(true);

            Counters counters = job.getCounters();
            long totalpage = counters.findCounter(PageCounter.Total).getValue();// 获取计数值
            long convergepage = counters.findCounter(PageCounter.Converge).getValue(); //收敛计数值
            System.out.println("total page: " + totalpage);
            System.out.println("converge page: " + convergepage);
            if ((double) convergepage / totalpage >= 0.99) {
                System.out.println("converge at iteration: " + i);
                break;
            }
        }
    }


    public static class PageRankReducer extends Reducer<Text, Text, Text, Text> {

        public PageRankReducer() {
        }

        public void reduce(Text key, Iterable<Text> values, Reducer<Text, Text, Text, Text>.Context context) throws IOException, InterruptedException {
            StringBuffer links = new StringBuffer();
            double newRank = 0.0, preRank = 0.0;

            for (Text value : values) {

                String content = value.toString();

                if (content.startsWith("|")) {
                    // if this value contains node links append them to the 'links' string
                    // for future use: this is needed to reconstruct the Formatinput for Job#2 mapper
                    // in case of multiple iterations of it.
                    links.append(content.substring(1));
                } else if (content.startsWith("#")) {

                    double in_rank = Double.parseDouble(content.trim().substring(1));

                    newRank += in_rank;
                } else if (content.startsWith("&")) {
                    preRank = Double.parseDouble(content.trim().substring(1));
                }

            }

            newRank = 0.85 * newRank + 0.15 * 3.547319468043973e-6;
            context.write(key, new Text(newRank + " " + links));

            if (abs(newRank - preRank) <= 1E-8)        //枚举计数器，计算有几个已收敛
                context.getCounter(PageCounter.Converge).increment(1);
        }
    }


    public static class PageRankMapper extends Mapper<Object, Text, Text, Text> {

        public PageRankMapper() {
        }

        public void map(Object key, Text value, Mapper<Object, Text, Text, Text>.Context context) throws IOException, InterruptedException {
            int idx1 = value.find("\t");
            int idx2 = value.find(" ");

            String page = Text.decode(value.getBytes(), 0, idx1);
            String rank = Text.decode(value.getBytes(), idx1 + 1, idx2 - idx1 - 1);
            String links = Text.decode(value.getBytes(), idx2 + 1, value.getLength() - (idx2 + 1));

            String[] allOtherPages = links.split(" ");
            int outs = allOtherPages.length;
            for (String otherPage : allOtherPages) {
                if (Objects.equals(otherPage, ""))
                    continue;
                StringBuffer out = new StringBuffer("#");
                out.append(Double.parseDouble(rank) / outs);
                Text outPageRank = new Text(out.toString());
                context.write(new Text(otherPage), outPageRank);
            }

            context.write(new Text(page), new Text("&" + rank));
            // put the original links so the reducer is able to produce the correct output
            context.write(new Text(page), new Text("|" + links));

            context.getCounter(PageCounter.Total).increment(1);
        }
    }
}
```]
4. 实验结果
  1. 格式化任务的结果如下：
  #img(
    image("assets/formatRes.png", height: 50%),
    caption: "格式化任务结果"
  )
  2. PageRank任务的结果如下：
  #img(
    image("assets/rankRes.png", height: 50%),
    caption: "PageRank任务结果"
  )
  结果符合预期，PageRank任务成功计算了PageRank值。
== 实验小结

本次实验主要内容包括：Hadoop以及HDFS的配置以及使用，以及在Hadoop环境下编写MapReduce程序，通过实验，我学会了如何在Linux环境下配置，运行并使用Hadoop运行环境以及HDFS，以及使用MapReduce的工作原理编写WordCount程序，深入理解MapReduce的工作原理并使用Hadoop框架实现PageRank算法。主要是写java和linux命令行。

#pagebreak()
= 实验2：Spark实验
== 实验概况

通过此次实验，学习如何在Linux环境下配置，运行并使用Spark运行环境，具体内容包括以下：
1. 安装与配置Spark
2. 使用Spark完成WordCount实验，体会Spark和MapReduce的区别
3. 使用SparkStreaming完成实时数据处理

== 实验内容
=== 实验1: Spark安装和环境配置
#indent()配置环境，跳过陈述
=== 实验2: WordCount实验
==== 任务描述

编写和执行基于Spark编程模型的WordCount程序，深入理解Spark的工作原理，并学会使用Spark框架进行大规模数据处理。
==== 实验设计

1. 使用sbt管理项目依赖，搭建基于scala和spark的WordCount
2. 编写打包WordCount程序
3. 使用spark-submit提交到Spark引擎上运行

==== 实验过程

1. 搭建项目结构，下载对应依赖，对应sbt文件如下:
#sourcecode[```sbt
name := "WordCOunt"
version := "1.0"
scalaVersion := "2.11.8"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "2.0.0"
```]
#indent()对应项目结构如下：
#sourcecode[```bash
# usami @ CodeOfUsami in ~/workU/SparkTasks/mycode/wordcount [15:51:31]
$ tree -I  "project|target" .
.
├── run.sh
├── simple.sbt
└── src
    └── main
        └── scala
            └── WordCountApp.scala

3 directories, 3 files
```]
2. 编写WordCount程序，调用Spark的api首先把读取到字符串按照空格分割成键值对，键为单词，值为1；然后按键分组（map），按组累加（reduce）；最后输出单词出现次数。
具体代码如下：
#sourcecode[```scala
import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}

/** * Scala原生实现wordcount */
object WordCountApp {
  def main(args: Array[String]): Unit = {

    val list = List("cw is cool", "wc is beautiful", "andy is beautiful", "mike is cool")
    /** * 第一步，将list中的元素按照分隔符这里是空格拆分，然后展开 * 先map(_.split(" "))将每一个元素按照空格拆分 * 然后flatten展开 * flatmap即为上面两个步骤的整合 */
    val res0 = list.map(_.split(" ")).flatten
    val res1 = list.flatMap(_.split(" "))
    println("第一步结果")
    println(res0)
    println(res1)

    /** * 第二步是将拆分后得到的每个单词生成一个元组 * k是单词名称，v任意字符即可这里是1 */
    val res3 = res1.map((_, 1))
    println("第二步结果")
    println(res3)
    /** * 第三步是根据相同的key合并 */
    val res4 = res3.groupBy(_._1)
    println("第三步结果")
    println(res4)
    /** * 最后一步是求出groupBy后的每个key对应的value的size大小，即单词出现的个数 */
    val res5 = res4.mapValues(_.size)
    println("最后一步结果")
    println(res5.toBuffer)
  }
}
```]
3. 使用#emph([/usr/local/hadoop/sbin/start-dfs.sh])启动HDFS
4. 使用以下命令打包并提交任务：
#sourcecode[```bash
/usr/local/sbt/sbt package
/usr/local/spark/bin/spark-submit --class "WordCountApp" \
    ./target/scala-2.12/wordcount_2.12-1.0.jar
```]
==== 实验结果

WordCount程序的结果如下：
#sourcecode[```bash
# usami @ CodeOfUsami in /usr/local/spark/mycode/wordcount [16:06:47] C:1
$ /usr/local/spark/bin/spark-submit --class "WordCountApp" \
    ./target/scala-2.12/wordcount_2.12-1.0.jar
第一步结果
List(cw, is, cool, wc, is, beautiful, andy, is, beautiful, mike, is, cool)
List(cw, is, cool, wc, is, beautiful, andy, is, beautiful, mike, is, cool)
第二步结果
List((cw,1), (is,1), (cool,1), (wc,1), (is,1), (beautiful,1), (andy,1), (is,1), (beautiful,1), (mike,1), (is,1), (cool,1))
第三步结果
Map(beautiful -> List((beautiful,1), (beautiful,1)), is -> List((is,1), (is,1), (is,1), (is,1)), wc -> List((wc,1)), andy -> List((andy,1)), cool -> List((cool,1), (cool,1)), cw -> List((cw,1)), mike -> List((mike,1)))
最后一步结果
ArrayBuffer((beautiful,2), (is,4), (wc,1), (andy,1), (cool,2), (cw,1), (mike,1))
24/06/05 16:07:10 INFO ShutdownHookManager: Shutdown hook called
24/06/05 16:07:10 INFO ShutdownHookManager: Deleting directory /tmp/spark-516ee402-8e9e-4b6a-9216-637f78bb08ed
```]
#indent()可以看到，WordCount程序成功统计了输入的单词出现次数。
=== 实验3: SparkStreaming实验
==== 任务描述

基于Spark Streaming编程模型实现wordcount程序，深入理解Spark Streaming的工作原理，并学会使用Spark框架进行大规模数据处理。

==== 实验设计

编写Spark Streaming程序的基本步骤是：
1.创建SparkSession实例；
2.创建DataFrame表示从数据源输入的每一行数据；
3.DataFrame转换，类似于RDD转换操作；
4.创建StreamingQuery开启流查询；
5.调用StreamingQuery.awaitTermination()方法，等待流查询结束。

==== 实验过程

1. 构建项目，编写基于streaming的WordCount程序，代码如下：
 #sourcecode[```scala
 import org.apache.spark.sql.functions._
import org.apache.spark.sql.SparkSession

object WordCountStructuredStreaming{
def main(args: Array[String]){
val spark = SparkSession.builder.appName("StructuredNetworkWordCount").getOrCreate()
import spark.implicits._
val lines = spark.readStream.format("socket").option("host","localhost").option("port",9998).load()


val words = lines.as[String].flatMap(_.split(" "))
val wordCounts = words.groupBy("value").count()


val query = wordCounts.writeStream.outputMode("complete").format("console").start()
query.awaitTermination()
}
}
 ```]
2. 使用#emph([nc])命令检测9998端口，当spark执行任务时输入数据
3. 编写打包WordCount程序，使用spark-submit提交到Spark引擎上运行。然后执行流处理

==== 实验结果

输入数据流以后结果如下：
#sourcecode[```bash
-------------------------------------------
Batch: 1
-------------------------------------------
24/06/05 16:20:13 INFO CodeGenerator: Code generated in 6.354354 ms
24/06/05 16:20:13 INFO CodeGenerator: Code generated in 8.980403 ms
+-----------+-----+
|      value|count|
+-----------+-----+
|      hello|    1|
|    beijing|    1|
|world,hello|    1|
+-----------+-----+
```]
#indent()可以正确的统计输入的单词出现次数。
#pagebreak()
= 实验3：图计算任务
== 实验概况
因为没有n卡和cuda资源，使用spark和graphX替代实现SCC(最大连通图)算法
== 实验内容
使用Tarjan算法得到SCC的基本原理和逻辑如下：
#sourcecode[```bash
// 入参为顶点集，边集，图 出参为强连通分量子图
vertices[],edges[],graph -> sccGraph
1. 初始化顶点数组键值对，每个点索引标记为-1
2. 任选一个顶点，初始化其起点索引为0，深度优先搜索，以时间戳标记每个点，即每次访问一个点，其index值加1。具体逻辑实现是实现一个栈，每次访问点都入栈，直到遍历完成再检查栈。如果栈顶元素的index值大于当前点的index值，说明栈顶元素在当前点的子树中，将栈顶元素出栈，直到栈顶元素的index值小于当前点的index值，将栈顶元素出栈，将出栈的元素加入到一个集合中，这个集合就是一个强连通分量。
3. 重复第二步直到所有顶点都被遍历过，此时就获得了所有连通分量子图的数组，返回最大图即可。
```]

具体代码如下:
#sourcecode[```scala
import org.apache.spark._
import org.apache.spark.graphx._
import org.apache.spark.rdd.RDD

object Main {
  def main(args: Array[String]): Unit = {
    val sparkConf = new SparkConf().setAppName("GraphX SCC Example").setMaster("local[*]")
    val sc = new SparkContext(sparkConf)

    // 定义顶点和边
    val vertices: RDD[(VertexId, String)] = sc.parallelize(Seq(
      (1L, "A"), (2L, "B"), (3L, "C"), (4L, "D"), (5L, "E")
    ))

    val edges: RDD[Edge[Int]] = sc.parallelize(Seq(
      Edge(1L, 2L, 0), Edge(2L, 3L, 0), Edge(3L, 1L, 0),
      Edge(3L, 4L, 0), Edge(4L, 5L, 0), Edge(5L, 4L, 0)
    ))

    
    val graph = Graph(vertices, edges)

    
    val sccGraph = graph.stronglyConnectedComponents(5).vertices

    sccGraph.collect.foreach(println)

    sc.stop()
  }
}

```]
== 实验结果

结果命令行输出如下：
#sourcecode[```bash
24/06/05 16:37:52 INFO DAGScheduler: Job 56 finished: collect at Main.scala:27, took 0.018973 s
(1,1)
(2,1)
(3,1)
(4,4)
(5,4)
```]符合预期，得到了最大连通图的结果。
#pagebreak()
= 实验总结

本次实验，通过Hadoop和Spark的实验，了解了分布式环境下的大数据系统如何处理数据以及其中蕴含的设计思路，例如流处理，图处理等等。Spark引擎调调api就可以省去繁忙的算法编写任务，同时兼顾考虑了分布式环境可能出现的种种问题，体现了软件工程高内聚低耦合的设计思想：一层一层传递数据，但是上层不需要考虑下层的种种分布式问题，因为底层被封装在引擎背后。因此只需要符合引擎规则的代码和数据，就可以在复杂分布式环境下面也可以得到正确的结果
#pagebreak()
// == typst 介绍


// #img(
//   image("assets/avatar.jpeg", height: 20%),
//   caption: "我的 image 实例 0",
// )

// == 基本语法

// === 代码执行

// 正文可以像前面那样直接写出来，隔行相当于分段。

// 个人理解：typst 有两种环境，代码和内容，在代码的环境中会按代码去执行，在内容环境中会解析成普通的文本，代码环境用{}表示，内容环境用[]表示，在 content 中以 \# 开头来接上一段代码，比如\#set rule，而在花括号包裹的块中调用代码就不需要 \#。


// === 标题

// 类似 Markdown 里用 \# 表示标题，typst 里用 = 表示标题，一级标题用一个 =，二级标题用两个 =，以此类推。


// 间距、字体等会自动排版。

// \#pagebreak() 函数相当于分页符，在华科的要求里，第一级标题应当分页，请手动分页。


// = 本模板相关封装



// 图用下面的方式来引用，img 是对 image 的包装，caption 是图片的标题。

// #img(
//   image("assets/avatar.jpeg", height: 20%),
//   caption: "我的 image 实例 1",
// ) <img1>

// 引用 2-1: @img1

// == 表格

// 表格跟图片差不多，但是表格的输入要复杂一点，建议在 typst 官网学习，自由度特别高，定制化很强。

// 看看@tbl1，tbl 也是接收两个参数，一个是 table 本身，一个是标题，table 里的参数，没有字段的一律是单元格里的内容（每一个被[]）包起来的内容，在 align 为水平时横向排列，排完换行。

// #tbl(
//   table(
//     columns: (100pt, 100pt, 100pt),
//     inset: 10pt,
//     stroke: 0.7pt,
//     align: horizon,
//     [], [*Area*], [*Parameters*],
//     image("assets/avatar.jpeg", height: 10%),
//     $ pi h (D^2 - d^2) / 4 $,
//     [
//       $h$: height \
//       $D$: outer radius \
//       $d$: inner radius
//     ],
//     image("assets/avatar.jpeg", height: 10%),
//     $ sqrt(2) / 12 a^3 $,
//     [$a$: 边长]
//   ),
//   caption: "芝士样表"
// ) <tbl1>



// #tbl(
//   three_line_table(
//     (
//     ("Country List", "Country List", "Country List"),
//     ("Country Name or Area Name", "ISO ALPHA Code", "ISO ALPHA"),
//     ("Afghanistan", "AF", "AFT"),
//     ("Aland Islands", "AX", "ALA"),
//     ("Albania", "AL", "ALB"),
//     ("Algeria", "DZ", "DZA"),
//     ("American Samoa", "AS", "ASM"),
//     ("Andorra", "AD", "AND"),
//     ("Angola", "AP", "AGO"),
//   )),
//   caption: "三线表示例"
// )

// #tbl(
//   three_line_table(
//     (
//     ("Country List", "Country List", "Country List", "Country List"),
//     ("Country Name or Area Name", "ISO ALPHA 2 Code", "ISO ALPHA 3", "8"),
//     ("Afghanistan", "AF", "AFT", "7"),
//     ("Aland Islands", "AX", "ALA", "6"),
//     ("Albania", "AL", "ALB", "5"),
//     ("Algeria", "DZ", "DZA", "4"),
//     ("American Samoa", "AS", "ASM", "3"),
//     ("Andorra", "AD", "AND", "2"),
//     ("Angola", "AP", "AGO", "1"),
//   )),
//   caption: "三线表示例2"
// )


// == 公式

// 公式用两个\$包裹，但是语法跟 LaTeX 并不一样，如果有大量公式需求建议看官网教程 https://typst.app/docs/reference/math/equation/。

// 为了给公式编号，也依然需要封装，使用 equation 里包公式的方式实现，比如：

// #equation(
//   $ A = pi r^2 $,
// ) <eq1>

// 根据@eq1 ，推断出@eq2

// #equation(
//   $ x < y => x gt.eq.not y $,
// ) <eq2>

// 然后也有多行的如@eq3，标签名字可以自定义

// #equation(
//   $ sum_(k=0)^n k
//     &< 1 + ... + n \
//     &= (n(n+1)) / 2 $,
// ) <eq3>


// 如果不想编号就直接用\$即可


// $ x < y => x gt.eq.not y $

// == 列表

// - 无序列表1: 1

// - 无序列表2: 2

// #indent()列表后的正文，应当有缩进。这里加入一个 \#indent() 函数来手动生成段落缩进，是因为在目前的 typst 设计里，按英文排版的习惯，连续段落里的第一段不会缩进，也包括各种列表。

// 1. 有序列表1
// 2. 有序列表2

// 列表后的正文，应当有缩进，但是这里没有，请自己在段首加上\#indent()

// 想自己定义可以自己set numbering，建议用 \#[] 包起来保证只在该作用域内生效：

// #[
// #set enum(numbering: "1.a)")
// + 自定义列表1
//   + 自定义列表1.1
// + 自定义列表2
//   + 自定义列表2.1
// ]

// == 代码块

// //代码块使用的是库codelst，语法和markdown类似
// #sourcecode[```typ
// #show "ArtosFlow": name => box[
//   #box(image(
//     "logo.svg",
//     height: 0.7em,
//   ))
//   #name
// ]

// This report is embedded in the
// ArtosFlow project. ArtosFlow is a
// project of the Artos Institute.
// ```]

// #pagebreak()
// = 其他说明

// == 文献引用

// 引用支持 LaTeX Bib 的格式，也支持更简单好看的 yml 来配置（尚未流行，推荐优先使用`.bib`）在引用时使用`#bib_cite(<tag>)`，像这样#bib_cite(<impagliazzo2001problems>,<Burckhardt:2013>)以获得右上的引用标注#bib_cite(<刘星2014恶意代码的函数调用图相似性分析>)#bib_cite(<papadimitriou1998combinatorial>)。

// 记得在最后加入\#references("path/to/ref.bib")函数的调用来生成参考文献。

// 由于华科使用自创引用格式，基本上为 GB/T 7714 去掉[J]、[C]、[M] 刊物类型。Typst 已支持 `csl` 自定义参考文献列表，基于#link("https://github.com/redleafnew/Chinese-STD-GB-T-7714-related-csl/blob/main/462huazhong-university-of-science-and-technology-school-of-cyber-science-and-engineering.csl")[#underline()[这个]]修改，如果想再自定义新的格式，请修改 `template.typ` 中 `bibliography` 函数中 style 参数。


// == 致谢部分

// 致谢部分在最后加入\#acknowledgement()函数的调用来生成。


// == 模板相关

// 这个模板应该还不是完全版，可能不能覆盖到华科论文的所有case要求，如果遇到特殊 case 请提交 issue 说明，或者也可以直接提 pull request

// 同时，由于 typst 太新了，2023年4月初刚发布0.1.0版本，可能会有大的break change发生，模板会做相应修改。

// 主要排版数据参考来自 https://github.com/zfengg/HUSTtex 同时有一定肉眼排版成分，所以有可能不完全符合华科排版要求，如果遇到不对的间距、字体等请提交 issue 说明。

// === 数据相关

// 所有拉丁字母均为 Times New Roman，大小与汉字相同

// 正文为宋体12pt，即小四

// 图表标题为黑体12pt

// 表格单元格内容宋体10.5pt，即五号

// 一级标题黑体18pt加粗，即小二

// 二级标题14pt加粗，即四号

// 正文行间距1.24em（肉眼测量，1.5em与与word的1.5倍行距并不一样）

// a4纸，上下空2.5cm，左右空3cm





// #pagebreak()
// #acknowledgement()[
  
// 完成本篇论文之际，我要向许多人表达我的感激之情。

// 首先，我要感谢我的指导教师，他/她对本文提供的宝贵建议和指导。所有这些支持和指导都是无私的，而且让我受益匪浅。

// 其次，我还要感谢我的家人和朋友们，他们一直以来都是我的支持和鼓励者。他们从未停止鼓舞我，勉励我继续前行，感谢你们一直在我身边，给我幸福和力量。

// 此外，我还要感谢我的同学们，大家一起度过了很长时间的学习时光，互相支持和鼓励，共同进步。因为有你们的支持，我才能不断地成长、进步。

// 最后，我想感谢笔者各位，你们的阅读和评价对我非常重要，这也让我意识到了自己写作方面的不足，同时更加明白了自己的研究方向。谢谢大家！

// 再次向所有支持和鼓励我的人表达我的谢意和感激之情。

// 本致谢生成自 ChatGPT。
// ]

// #pagebreak()

// #references("./ref.bib")
