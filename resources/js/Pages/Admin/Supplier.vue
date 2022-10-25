<template>
    {{formState}}
    <a-button type="primary" @click="showModal">Add</a-button>
    <a-table :dataSource="dataSource.dataSet" :columns="columns">
        <template #bodyCell="{column, text, record, index}">
            <template v-if="column.dataIndex!='operation'">
                {{record[column.dataIndex]}}
            </template>
            <template v-else>
                <a-button @click="editRecord(record)">Edit</a-button>
                <a-button @click="deleteRecord(index)">Delete</a-button>
            </template>
        </template>
    </a-table>


    <a-modal v-model:visible="modalSetting.visible" title="Basic Modal" @ok="handleOk">
        <a-form
            :model="formState"
            name="basic"
            :label-col="{ span: 8 }"
            :wrapper-col="{ span: 16 }"
            autocomplete="off"
            @finish="onFinish"
            @finishFailed="onFinishFailed"
        >
            <a-form-item
            label="Username"
            name="username"
            :rules="[{ required: true, message: 'Please input your username!' }]"
            >
            <a-input v-model:value="formState.username" />
            </a-form-item>

            <a-form-item
            label="Password"
            name="password"
            :rules="[{ required: true, message: 'Please input your password!' }]"
            >
            <a-input-password v-model:value="formState.password" />
            </a-form-item>

            <a-form-item name="remember" :wrapper-col="{ offset: 8, span: 16 }">
            <a-checkbox v-model:checked="formState.remember">Remember me</a-checkbox>
            </a-form-item>

            <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
            <a-button type="primary" html-type="submit">Submit</a-button>
            </a-form-item>
        </a-form>
    </a-modal>    
</template>

<script setup>
import { defineComponent, onMounted, reactive,ref } from 'vue';

const modalSetting=ref({
    visible:false
})
const formState=reactive({})

const columns=ref([
    {
        title: 'Name',
        dataIndex: 'name_zh',
        key: 'name',
    },
    {
        title: 'Age',
        dataIndex: 'phone',
        key: 'age',
    },
    {
        title: 'Address',
        dataIndex: 'address',
        key: 'address',
    },
    {
        title: 'Operation',
        dataIndex: 'operation',
        key: 'operation',
    },
]);

const dataSource=reactive({});

const editRecord=(record)=>{
    formState={...record};
}

const deleteRecord=(index)=>{
    alert("Delete Record: "+index);
}
const showModal=()=>{
    console.log("showModal");
    modalSetting.value.visible=true;
}
const handleOk = e => {
    console.log(e);
    modalSetting.value.visible = false;
}

const fetchData =()=>{
    axios.get('../supplier')
        .then(response=>{
            dataSource.dataSet=response.data.dataSet.data;
            console.log(response.data);
        }
    )
}

onMounted(()=>{
    fetchData();
    console.log("mounted");
});

</script>