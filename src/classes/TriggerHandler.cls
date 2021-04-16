public virtual class TriggerHandler {

    public static Boolean canRun = true;

    public virtual void run(System.TriggerOperation event) {
        switch on event {
            when BEFORE_INSERT {
                this.beforeInsert();
            }
            when BEFORE_UPDATE {
                this.beforeUpdate();
            }
            when BEFORE_DELETE {
                this.beforeDelete();
            }
            when AFTER_INSERT {
                this.afterInsert();
            }
            when AFTER_UPDATE {
                this.afterUpdate();
            }
            when AFTER_DELETE {
                this.afterDelete();
            }
            when AFTER_UNDELETE {
                this.afterUndelete();
            }
        }
    }

    public static void run(TriggerHandler handler) {
        handler.run(Trigger.operationType);
    }

    protected virtual void beforeInsert() {

    }

    protected virtual void afterInsert() {

    }

    protected virtual void beforeUpdate() {

    }

    protected virtual void afterUpdate() {

    }

    protected virtual void beforeDelete() {

    }

    protected virtual void afterDelete() {

    }

    protected virtual void beforeUndelete() {

    }

    protected virtual void afterUndelete() {

    }
}