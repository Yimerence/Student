<template>
  <div>
    <div class="card" style="margin-bottom: 10px">
      <el-input style="width: 260px; margin-right:10px" v-model="data.username" class="w-50 m-2" placeholder="请输入账号查询"
                :prefix-icon="Search"/>
      <el-input style="width: 260px; margin-right:10px" v-model="data.name" class="w-50 m-2" placeholder="请输入名称查询"
                :prefix-icon="Search"/>
      <el-button type="primary" style="margin-left:10px" @click="load">查询</el-button>
      <el-button type="info" @click="reset">重置</el-button>
    </div>

    <div class="card" style="margin-bottom:10px">
      <div style="margin-bottom: 10px">
        <el-button type="primary" @click="handelAdd">新增</el-button>
      </div>

      <div>
        <el-table :data="data.tableData" style="width: 100%">>
          <el-table-column prop="id" label="序号" width="180"/>
          <el-table-column prop="username" label="学生账号" width="180"/>
          <el-table-column prop="name" label="学生名称"/>
          <el-table-column prop="phone" label="学生手机号"/>
          <el-table-column prop="email" label="学生邮箱"/>
          <el-table-column prop="sex" label="性别"/>
          <el-table-column prop="birth" label="生日"/>
          <el-table-column prop="avatar" label="头像">
<!--          <el-table-column>-->
            <template #default="scope">
              <el-image v-if="scope.row.avatar" :src="scope.row.avatar" :preview-src-list="[scope.row.avatar]" style="width: 40px; height: 40px;border-radius: 5px"></el-image>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="180">
            <template #default="scope">
              <el-button type="primary" @click="handleEdit(scope.row)" size="small" plain>编辑</el-button>
              <el-button type="danger" @click="del(scope.row.id)" size="small" plain>删除</el-button>
            </template>
          </el-table-column>
        </el-table>

      </div>

      <div class="card">
        <el-pagination v-model:current-page="data.pageNum" v-model:page-size="data.pageSize"
                       @current-change="handelCurrentChange"
                       layout="prev, pager, next" :total="data.total"/>
      </div>

      <el-dialog width="35%" v-model="data.formVisible" title="学生信息" destroy-on-close>
        <el-form :model="data.form" :rules="rules" ref="formRef" label-width="100px" label-position="right"
                 style="padding-right: 40px">
          <el-form-item label="学生账号" prop="username">
            <el-input v-model="data.form.username" autocomplete="off"/>
          </el-form-item>
          <el-form-item label="学生密码" prop="password">
            <el-input show-password v-model="data.form.password" autocomplete="off"/>
          </el-form-item>
          <el-form-item label="学生名称">
            <el-input v-model="data.form.name" autocomplete="off"/>
          </el-form-item>
          <el-form-item label="手机号">
            <el-input v-model="data.form.phone" autocomplete="off"/>
          </el-form-item>
          <el-form-item label="邮箱">
            <el-input v-model="data.form.email" autocomplete="off"/>
          </el-form-item>
          <el-form-item label="性别" >
            <el-radio-group v-model="data.form.sex" class="ml-4">
              <el-radio label="男"></el-radio>
              <el-radio label="女"></el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="生日">
            <el-date-picker format="YYYY-MM-DD" value-format="YYYY-MM-DD" v-model="data.form.birth"></el-date-picker>
          </el-form-item>
          <el-form-item label="学生头像">
            <el-upload action="http://localhost:9090/files/upload" list-type="picture"
                       :on-success="handleImgUploadSuccess">
              <el-button type="primary">上传头像</el-button>
            </el-upload>
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
import {ref, reactive} from "vue";
import {Search} from "@element-plus/icons-vue";
import request from "../../utils/request";
import {ElMessage, ElMessageBox} from "element-plus";

const baseUrl = '/student'

const data = reactive({
  username: '',
  name: '',
  tableData: [],
  total: 0,
  pageNum: 1, //当前页码
  pageSize: 5, //每页的个数
  formVisible: false,
  form: {}
})

const load = () => {
  request.get(baseUrl + '/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      username: data.username,
      name: data.name,
    }
  }).then(res => {
    data.tableData = res.data?.list || []
    data.total = res.data?.total || 0
  })
}
//调用方法调用后台数据
load()

const handelCurrentChange = () => {
// 翻页的时候重载数据
  load()
}

const reset = () => {
  data.username = ''
  data.name = ''
  load()
}

const rules = reactive({
  username: [
    {required: true, message: '请输入账号', trigger: 'blur'},
    {min: 3, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],
  password: [
    {required: true, message: '请输入密码', trigger: 'blur'},
    {min: 3, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],
})

const formRef = ref()

const handelAdd = () => {
  data.form = {}
  data.formVisible = true
}
//保存数据到后台
const save = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      request.request({
        url: data.form.id ? baseUrl + '/update' : baseUrl + '/add',
        method: data.form.id ? 'PUT' : 'POST',
        data: data.form
      }).then(res => {
        if (res.code === '200') {
          //重载获取数据
          load()
          data.formVisible = false  //关闭弹窗
          ElMessage.success("操作成功")
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })

}
//编辑
const handleEdit = (row) => {
  data.form = JSON.parse(JSON.stringify(row))//深拷贝到弹窗
  data.formVisible = true
}
//删除
const del = (id) => {
  ElMessageBox.confirm('删除数据无法恢复，请三思', '删除确认', {type: 'warning'}).then(res => {
    request.delete(baseUrl + '/delete/' + id).then(res => {
      if (res.code === '200') {
        //重载获取数据
        load()
        ElMessage.success("操作成功")
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(res => {
    ElMessage({
      type: 'info',
      message: '删除取消',
    })
  })
}

const handleImgUploadSuccess = (res) => {
  data.form.avatar = res.data
}
</script>