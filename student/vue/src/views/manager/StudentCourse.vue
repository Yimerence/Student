<template>
  <div>
    <div class="card" style="margin-bottom: 10px">
      <el-input style="width: 260px; margin-right:10px" v-model="data.name" class="w-50 m-2" placeholder="请输入课程名称查询" :prefix-icon="Search"/>
      <el-input style="width: 260px; margin-right:10px" v-model="data.no" class="w-50 m-2" placeholder="请输入课程编号查询" :prefix-icon="Search"/>
      <el-input style="width: 260px" v-model="data.teacher" placeholder="请输入任课老师查询" :prefix-icon="Search"/>
      <el-button type="primary" style="margin-left:10px" @click="load">查询</el-button>
      <el-button type="info" @click="reset">重置</el-button>
    </div>

    <div class="card" style="margin-bottom:10px">

      <div>
        <el-table :data="data.tableData" style="width: 100%">
          <el-table-column prop="id" label="序号" width="180" />
          <el-table-column prop="name" label="课程名称" width="180" />
          <el-table-column prop="no" label="课程编号" />
          <el-table-column prop="studentName" label="学生名称" />
          <el-table-column label="操作" width="180">
            <template #default="scope">
              <el-button type="danger" @click="del(scope.row.id)">删除</el-button>
              <el-button type="primary" @click="addGrade(scope.row)" v-if="data.user.role ==='ADMIN'">评分</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>

      <div class="card">
        <el-pagination v-model:current-page="data.pageNum" v-model:page-size="data.pageSize"
                       @current-change="handelCurrentChange"
                       layout="prev, pager, next" :total="data.total" />
      </div>

      <el-dialog width="35%" v-model="data.formVisible" title="成绩信息">
        <el-form :model="data.gradeForm" label-width="100px" label-position="right" style="padding-right: 40px">
          <el-form-item label="课程名称">
            <el-input v-model="data.gradeForm.name" autocomplete="off" disabled />
          </el-form-item>
          <el-form-item label="分数">
            <el-input v-model="data.gradeForm.score" autocomplete="off"/>
          </el-form-item>
          <el-form-item label="评语">
            <el-input type="textarea" v-model="data.gradeForm.comment" autocomplete="off"/>
          </el-form-item>
        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="data.formVisible = false">取消</el-button>
            <el-button type="primary" @click="save">保存</el-button>
          </span>
        </template>
      </el-dialog>

    </div>

  </div>
</template>

<script setup>
import {reactive} from "vue";
import {Search} from "@element-plus/icons-vue";
import request from "../../utils/request";
import {ElMessage, ElMessageBox} from "element-plus";

const data =reactive({
  name:'',
  no:'',
  tableData:[],
  total:0,
  pageNum:1, //当前页码
  pageSize:5, //每页的个数
  user:JSON.parse(localStorage.getItem('student-user')||'{}'),
  gradeForm:{},
  formVisible:false
})

const load = () =>{
  let params ={
    pageNum:data.pageNum,
    pageSize:data.pageSize,
    name:data.name,
    no:data.no
  }
  if (data.user.role === 'STUDENT'){//如果当前登录的是学生，就查询自己的选课记录
    params.studentId = data.user.id //拼接当前用户的ID
  }
  request.get('/studentCourse/selectPage',{
    params:params
  }).then(res=>{
    data.tableData = res.data?.list || []
    data.total = res.data?.total  || 0
  })
}
//调用方法调用后台数据
load()

const handelCurrentChange = (pageNum) =>{
  load()
}

const reset = () =>{
  data.name =''
  data.no =''
  load()
}

const del = (id) => {
  ElMessageBox.confirm('删除数据无法恢复，请三思','删除确认',{type:'warning'}).then(res=>{
    request.delete('/studentCourse/delete/' + id).then(res => {
      if(res.code ==='200'){
        //重载获取数据
        load()
        ElMessage.success("操作成功")
      }else{
        ElMessage.error(res.msg)
      }
    })
  }).catch(res =>{
    ElMessage({
      type:'info',
      message:'删除取消',
    })
  })
}
//评分
const addGrade = (row) => {
  //弹窗
  data.formVisible = true
  data.gradeForm.name = row.name
  data.gradeForm.courseId = row.courseId
  data.gradeForm.studentId = row.studentId
}

const save = () =>{
  request.post('/grade/add',data.gradeForm).then(res => {
    if(res.code ==='200'){
      data.formVisible = false  //关闭弹窗
      ElMessage.success("操作成功")
    }else{
      ElMessage.error(res.msg)
    }
  })
}
</script>