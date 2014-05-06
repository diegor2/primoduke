#include "ramdisk.h" 

static int copied;
static char* disk;

/*  
 * Tabela com as funções de manipulação de arquivos
 * Pode ser chamada de "jump table"
 * As funções declaradas aqui sobrescrevem as operações padrão.
 */
static struct file_operations fops = {
	.read = device_read,
	.write = device_write,
	.open = device_open,
	.release = device_release
};

static struct miscdevice mdev = {
        .minor = MISC_DYNAMIC_MINOR,
        .name = DEVICE,
        .fops = &fops,
};

/* ---------------------------------------------------------------- */

static ssize_t device_read(struct file *filp, char *buffer, size_t length,loff_t * offset)
{
	if(copied) return 0;
	/* 
	 * Copia a mensagem para o buffer que está no espaço 
	 * de memória do usuário
	 */	
	if(copy_to_user(buffer, disk, DISK_SIZE) == SUCCESS){
		copied++;
		printk(KERN_INFO "Conteudo do disco virtual lido");
		return DISK_SIZE;
	} else {
		printk(KERN_ALERT "Erro ao ler disco virtual");
		return -EIO; /* Erro de entrada e saida. I/O error. */
	}
}

static ssize_t device_write(struct file *filp, const char *buff, size_t len, loff_t * off)
{
	len = (len > DISK_SIZE) ? DISK_SIZE : len;
	if(copy_from_user(disk, buff, len) == SUCCESS){
		printk(KERN_INFO "Conteudo escrito no disco virtual");
		return len;
	} else {
		printk(KERN_ALERT "Erro ao escrever no disco virtual");
		return -EIO;
	}
}

static int device_open(struct inode *inode, struct file *file)
{
	copied = 0;
	printk(KERN_INFO "arquivo aberto");
	return 0; /* Success */
}

static int device_release(struct inode *inode, struct file *file)
{
	printk(KERN_INFO "arquivo liberado");
	return 0;
}

/* ---------------------------------------------------------------- */

/* Função que será chamada quando o modulo é instalado */
static int __init hello_module(void)
{
	int ret;
	disk = (char*) kzalloc(DISK_SIZE * sizeof(char), GFP_KERNEL);
	if(!disk){
		printk(KERN_ALERT "Erro ao alocar memoria"); /* Error */
		return -ENOMEM;
	}
	ret = misc_register(&mdev);
	if(ret == SUCCESS)
		printk(KERN_INFO "Dispositivo registrado"); /* OK */
	else
		printk(KERN_ALERT "Erro ao registrar dispositivo"); /* Error */
	return ret;
}

/* Função que será chamada quando o modulo é removido  */
static void __exit goodbye_module(void)
{
	kfree(disk);
	misc_deregister(&mdev);
	printk(KERN_INFO "Dispositivo removido\n");

}

/* Registra quais funções devem ser chamadas para cada "evento"  */
module_init(hello_module);
module_exit(goodbye_module);

/* Informações sobre o módulo  */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Diego Ruggeri");
MODULE_DESCRIPTION("RAMDisk device module");
