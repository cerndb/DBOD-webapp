package ch.cern.dod.db.entity;

/**
 * This class represents a job statistic.
 * @author Daniel Gomez Blanco
 */
public class DODJobStat implements Comparable{
    /**
     * DB name of the instance.
     */
    private String dbName;
    /**
     * Name of the command executed.
     */
    private String commandName;
    /**
     * Count of the executed commands
     */
    private int count;
    /**
     * Mean duration of the command executions
     */
    private int meanDuration;

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

    public String getCommandName() {
        return commandName;
    }

    public void setCommandName(String commandName) {
        this.commandName = commandName;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getMeanDuration() {
        return meanDuration;
    }

    public void setMeanDuration(int meanDuration) {
        this.meanDuration = meanDuration;
    }

    public int compareTo(Object o) {
        return dbName.compareTo(((DODJobStat)o).getDbName());
    }
}
