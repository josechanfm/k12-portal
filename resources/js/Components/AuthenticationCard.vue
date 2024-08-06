<template>
    <div class="login-background min-h-screen flex flex-col pt-24 sm:pt-2 sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100 ">
        

        <div class="w-full sm:max-w-md mt-6 px-6 py-4 bg-white shadow-md sm:rounded-lg">
            <div class="flex justify-center -mt-14">
                <slot name="logo" />
            </div>


            <slot />
        </div>
    </div>
</template>

<style>
.login-background{
    background: rgb(237,228,254);
    background: linear-gradient(90deg, rgba(237,228,254,1) 0%, rgba(205,205,224,1) 37%, rgba(217,226,255,1) 100%);
}
</style>
