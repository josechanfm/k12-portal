import { usePage } from '@inertiajs/inertia-vue3';

const hasPermission = (permission) => {
    const permissions = usePage().props.value.currentUserPermissions
    return permissions.includes(permission)
}

function checkPermission(el, binding) {
    const { value } = binding
    if (!hasPermission(value)) {
        el.style.display = 'none';
        //el.parentNode && el.parentNode.removeChild(el)
    }
}

const hasRole = (role) => {
    const userRoles=usePage().props.value.user.roles.map(u=>u.name);
    if(Array.isArray(role)){
         return role.some(r=>{
            return userRoles.includes(r)
         })
    }else{
        return userRoles.includes(role)
    }

}


function checkRole(el, binding) {
    const { value } = binding
    if (!hasRole(value)) {
        el.style.display = 'none';
        //el.parentNode && el.parentNode.removeChild(el)
    }
}

const permission = {
    created (el, binding) {
        checkPermission(el, binding)
    },
    beforeUpdate (el, binding) {
        checkPermission(el, binding)
    }
}
const role = {
    created (el, binding) {
        checkRole(el, binding)
    },
    beforeUpdate (el, binding) {
        checkRole(el, binding)
    }
}


export default {
    install (app, options) {
        app.directive('can', permission)
        app.directive('role', role)
        app.config.globalProperties.$can = hasPermission
        app.config.globalProperties.$is = hasRole
    }
}