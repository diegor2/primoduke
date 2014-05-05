#include "device.h" 

static int major;
static int copied;
static char message[BUFF_LEN];

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

/* ---------------------------------------------------------------- */

static ssize_t device_read(struct file *filp, char *buffer, size_t length,loff_t * offset)
{
	int len;
	printk(KERN_INFO "read");
	/*
	 * Se a mensagem já tiver sido copiada para o buffer,
	 * retorna 0 para indica EOF (fim do "arquivo")
	 */
	if(copied) return 0;

	/* 
	 * Copia a mensagem para o buffer que está no espaço 
	 * de memória do usuário
	 */	
	len = strnlen(message, BUFF_LEN);
	if(copy_to_user(buffer, message, len) == SUCCESS){
		copied++;
		printk(KERN_INFO "Mensagem lida");
		return len;
	} else {
		printk(KERN_ALERT "Erro ao ler mensagem");
		return -EIO; /* Erro de entrada e saida. I/O error. */

	}
}

static ssize_t device_write(struct file *filp, const char *buff, size_t len, loff_t * off)
{
	printk(KERN_INFO "write");
	return 0;
}

static int device_open(struct inode *inode, struct file *file)
{
	printk(KERN_INFO "open");
	/* Cada vez que o "arquivo" é aberto, inclui uma exclamação */
	copied = 0; 
	sprintf(message, "%s%s", message, "!");
	return 0; /* Success */
}

static int device_release(struct inode *inode, struct file *file)
{
	printk(KERN_INFO "release");
	return 0;
}

/* ---------------------------------------------------------------- */

/* Função que será chamada quando o modulo é instalado */
static int __init hello_module(void)
{
	strncpy(message, FISL_MESSAGE, BUFF_LEN);

	major = register_chrdev(0, DEVICE, &fops);	
	if(major<0)
		printk(KERN_ALERT "Erro ao registrar dispositivo"); /* Error */
	else
		printk(KERN_INFO "Dispositivo registrado com major= %d", major); /* OK */
	return 0;
}

/* Função que será chamada quando o modulo é removido  */
static void __exit goodbye_module(void)
{
	unregister_chrdev(major, DEVICE);
	printk(KERN_INFO "Dispositivo removido\n");

}
/* Registra quais funções devem ser chamadas para cada "evento"  */
module_init(hello_module);
module_exit(goodbye_module);

/* Informações sobre o módulo  */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Diego Ruggeri");
MODULE_DESCRIPTION("Char device module");
