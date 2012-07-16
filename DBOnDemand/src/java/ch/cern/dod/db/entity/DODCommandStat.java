package ch.cern.dod.db.entity;

/**
 * This class represents a command statistic.
 * @author Daniel Gomez Blanco
 */
public class DODCommandStat {
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
    private float meanDuration;

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

    public float getMeanDuration() {
        return meanDuration;
    }

    public void setMeanDuration(float meanDuration) {
        this.meanDuration = meanDuration;
    }
}