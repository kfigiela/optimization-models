import cws.core.dag.algorithms.TopologicalOrder
import cws.core.dag.{DAG, Task, DAGParser}
;
import collection.JavaConversions._


import java.io.File
import java.util.Locale
;

class TaskGroup(val transformation: String, val count: Integer, val input: Double, val output: Double, val size: Double) {
  override def toString = "T_" + ("[^A-Za-z_]".r.replaceAllIn(transformation, ""))
}

class Layer(val tasks: List[Task], dag: DAG) {
  val taskGroups = groupTasks(dag)
  override def toString = "L_" + ("[^A-Za-z_]".r.replaceAllIn(taskGroups.map(_.transformation).mkString("_"), ""))

  def groupTasks(dag: DAG):Iterable[TaskGroup] = {
    tasks.groupBy(_.transformation).map( _ match {
      case (transformation, group) => {
        val inputs = group.map(_.inputs.map(dag.getFileSize(_)).sum).sum/group.size/(1024*1024)
        val outputs = group.map(_.outputs.map(dag.getFileSize(_)).sum).sum/group.size/(1024*1024)
        val size = group.map(_.size).sum/group.size
        new TaskGroup(transformation, group.size, inputs, outputs, size )
      }
    })
  }
}

object Main {


  def layerize(dag: DAG): List[Layer] = {
    def rec(layers: List[Layer], done: Set[Task], remaining: List[Task]):List[Layer] = {
      if(remaining.isEmpty) {
        layers
      } else {
        val (newLayer, newRemaining) = remaining.partition(_.parents.forall(done.contains(_)))
        rec(new Layer(newLayer, dag) :: layers, done ++ newLayer, newRemaining)
      }
    }

    rec(List(), Set(), dag.getTaskList.toList).reverse
  }

  def main(args: Array[String]) {

    Locale.setDefault(new Locale("en")) // set locale to english to force dot as decimal separator

    val dag = DAGParser.parseDAG(new File(args(0)))
    val layers = layerize(dag)


    println("set TASK = " + layers.map(_.taskGroups.mkString(" ")).mkString(" ") + ";")
    println("set LAYER = " + layers.mkString(" ") + ";")

    println


    layers.foreach(l =>
      println("set LAYER_TASK[" + l + "] = " + l.taskGroups.mkString(" ") + ";")
    )

    println

    println("param: \n                           task_count exec_time data_size_in data_size_out :=")
    layers.foreach(_.taskGroups.foreach((task) =>
      println("    %20s   %10d %12.6f %12.6f %12.6f".format(task, task.count, task.size/3600.0, task.input, task.output))
    ))
    println(";")

  }
}
