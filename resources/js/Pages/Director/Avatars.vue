<template>
<AdminLayout title="Dashboard">
    <div>
        <div class="font-black text-zinc-500 text-2xl"> 學生頭像</div>
        <div class="text-red-500 font-black text-lg bg-gray-200 p-4  w-full rounded-lg">
            *注意事項: 相片命名請以<span  class="text-red-700 italic">大寫班別+學號形式(e.g K1A01, P1B32)</span> ,文件只接受SVG, PNG, JPG 等圖片格式, 尺寸不超過800x400, 文件大小不大於2MB
        </div>
        <div>
            <div class="flex items-center justify-center w-full">
                <label for="dropzone-file" class="flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600">
                    <div class=" flex flex-col items-center justify-center font-black text-2xl text-slate-500">
                        <UploadOutlined class="text-3xl"></UploadOutlined>點擊或拖曳圖片到此位置以進行上傳
                    </div>
                    <input id="dropzone-file" type="file" ref="fileInput" multiple class="hidden" @change="handleFileChange" />
                </label>
            </div>
        </div>
        <div class="bg-white rounded-lg p-4">
            <div class="flex">
                <div class="flex-1 font-black text-slate-700 text-2xl">處理列</div><a-button class="text-blue-500" type="text"  @click="displayh=!displayh">隱藏/展開</a-button>
            </div>
            <div  class="flex items-center justify-center"
                    v-if="processList.map(x=>x.status).includes(0)">
                    <div class="text-2xl font-black text-blue-500">處理中</div><a-spin></a-spin>
             </div>
             <div   :class="displayh?'h-full':'h-0 overflow-hidden'">
                <div v-for="p in processList" :key="p"  class="bg-gray-100 p-1 rounded-lg  flex gap-1 font-black" :class="status_color[p.status]" >
                <div class="w-[4cm]"> {{ status[ p.status] }}</div>
                    <div> {{ p.name }}</div>
                </div>
            </div>
        </div>
        <div class="bg-sky-50 p-4 flex flex-col gap-2">
            <div class="font-black text-sky-500 text-2xl">已成功上傳</div>

           
            <div class="flex gap-4">
                <div :key=" avatar.full_tag " v-for="avatar in avatars" class="flex flex-col items-center justify-center bg-zinc-50 border-sky-600 rounded-lg  bg-slate-100">
                    <img class="border rounded-t-lg" :src="avatar.url" width="100" />
                    <div class="bg-zinc-500 py-1 w-full text-white flex flex-col items-center rounded-b-lg">
                        <div class="font-black"> {{ avatar.full_tag }}</div>
                        <div class="font-black"> {{ avatar.student_name }}</div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import {
    InboxOutlined,UploadOutlined,
} from '@ant-design/icons-vue';
import {
    AvatarGroup,
    message
} from 'ant-design-vue';

export default {
    components: {
        AdminLayout,UploadOutlined,
        InboxOutlined,
        message
    },
    props: [],
    data() {
        return {
            displayh:true,
            status_color:{'0':'text-black','1':'text-red-500','2':'text-amber-600','3':'text-green-600'},
            status:{'0':'Proccessing','1':'Fail size or Ext','2':'Not found student','3':'Success'},
            processList:[],
            avatars: [],
            dragging: false,
        }
    },
    created() {},
    mounted() {

    },
    methods: {
        emptyProcessList(){
            this.processList=[]
            this.avatars=[]
        },
        handleDragEnter(event) {
            event.preventDefault();
            this.dragging = true;
        },
        handleDragOver(event) {
            event.preventDefault();
        },
        handleDragLeave() {
            this.dragging = false;
        },
        handleDrop(event) {
            event.preventDefault();
            this.dragging = false;
            const file = event.dataTransfer.files[0];
            this.handleFile(file);
        },
        handleFileChange() {
            var files = this.$refs.fileInput.files;
            Object.entries(files).forEach(([i, file]) => {
                this.verifyFile(file)
            })
        },
        
      async  uploadFile(klassStudentId, file) {
        const resp =  await axios.post(route('teacher.avatars.store'), {
                avatar: file,
                klassStudentId: klassStudentId
            }, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            })
            this.avatars.push(resp.data)
            return resp.data.length!=0
        },
        handleFile(file) {
            // Perform any necessary file handling logic
            console.log(file);
        },
        openFileDialog() {
            this.$refs.fileInput.click();
        },
        handleChange(info) {
            //console.log(info.file, info.fileList);
            const status = info.file.status

            if (status !== 'uploading') {
                console.log('uploading')
            }
            if (status === 'done') {
                message.success(`${info.file.name} file uploaded successfully.`);
            } else if (status === 'error') {
                message.error(`${info.file.name} file upload failed.`);
            }
        },
     async   verifyFile(file) {
            let temp_id= this.processList.length
            this.processList[temp_id]={ name:file?.name??'error-name',status:0}
            const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
            if (!isJpgOrPng) {
                message.error('You can only upload JPG file!');
                this.processList[temp_id]['status']=1;
                return false
            }
            const isLt2M = file.size / 1024 / 1024 < 2;
            if (!isLt2M) {
                message.error('Image must smaller than 2MB!');
                this.processList[temp_id]['status']=1;
                return false
            }
          const res= await axios.get(route('avatar.verifyFilename', {
                filename: file.name}), )
            if(!res.data){
                 this.processList[temp_id]['status']=2
                return false
            }
              const check=  await this.uploadFile(res.data.pivot.klass_student_id, file)
                this.processList[temp_id]['status']=check?3:1
            //return isJpgOrPng && isLt2M;
        },
        handleDrop() {
            console.log('handle drop');
        }
    },
}
</script>
